#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: find-models.sh [options]

Find provider/model offerings in the current models.dev catalog. Outputs JSON.
The catalog is fetched or refreshed transparently by models.sh.

Filters:
  --query <text>             Match provider/model ID, name, or description.
  --provider <id>            Require an exact provider ID.
  --reasoning                Require reasoning support.
  --tools                    Require tool-call support.
  --structured-output        Require structured-output support.
  --open-weights             Require open weights.
  --input-modality <type>    Require an input modality (repeatable).
  --output-modality <type>   Require an output modality (repeatable).
  --min-context <tokens>     Require at least this context limit.
  --min-output <tokens>      Require at least this output-token limit.
  --max-input-cost <price>   Maximum input price per million tokens.
  --max-output-cost <price>  Maximum output price per million tokens.

Output:
  --sort <field>             input-cost, output-cost, context, or updated
                             (default: input-cost).
  --limit <count>            Maximum results (default: 10).
  --force-update             Refresh the catalog immediately.
  -h, --help                 Show this help.

Examples:
  find-models.sh --query claude --tools --limit 5
  find-models.sh --reasoning --tools --min-context 200000 --max-input-cost 5
  find-models.sh --input-modality image --structured-output --sort context
EOF
}

query=""
provider=""
reasoning=false
tools=false
structured_output=false
open_weights=false
input_modalities=()
output_modalities=()
min_context=""
min_output=""
max_input_cost=""
max_output_cost=""
sort="input-cost"
limit=10
force_update=()

value() {
  if [[ $# -lt 2 ]]; then
    echo "error: $1 expects a value" >&2
    exit 2
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --query) value "$@"; query="$2"; shift 2 ;;
    --provider) value "$@"; provider="$2"; shift 2 ;;
    --reasoning) reasoning=true; shift ;;
    --tools) tools=true; shift ;;
    --structured-output) structured_output=true; shift ;;
    --open-weights) open_weights=true; shift ;;
    --input-modality) value "$@"; input_modalities+=("$2"); shift 2 ;;
    --output-modality) value "$@"; output_modalities+=("$2"); shift 2 ;;
    --min-context) value "$@"; min_context="$2"; shift 2 ;;
    --min-output) value "$@"; min_output="$2"; shift 2 ;;
    --max-input-cost) value "$@"; max_input_cost="$2"; shift 2 ;;
    --max-output-cost) value "$@"; max_output_cost="$2"; shift 2 ;;
    --sort) value "$@"; sort="$2"; shift 2 ;;
    --limit) value "$@"; limit="$2"; shift 2 ;;
    --force-update) force_update=(--force-update); shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "error: unexpected argument: $1" >&2; exit 2 ;;
  esac
done

for pair in "min context:$min_context" "min output:$min_output" "limit:$limit"; do
  name="${pair%%:*}"
  number="${pair#*:}"
  if [[ -n "$number" ]] && ! [[ "$number" =~ ^[0-9]+$ ]]; then
    echo "error: $name must be a non-negative integer" >&2
    exit 2
  fi
done
for pair in "max input cost:$max_input_cost" "max output cost:$max_output_cost"; do
  name="${pair%%:*}"
  number="${pair#*:}"
  if [[ -n "$number" ]] && ! [[ "$number" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    echo "error: $name must be a non-negative number" >&2
    exit 2
  fi
done
case "$sort" in
  input-cost|output-cost|context|updated) ;;
  *) echo "error: --sort must be input-cost, output-cost, context, or updated" >&2; exit 2 ;;
esac

json_array() {
  if (($#)); then printf '%s\n' "$@" | jq -Rsc 'split("\n")[:-1]'; else printf '[]'; fi
}
input_json='[]'
output_json='[]'
if ((${#input_modalities[@]})); then input_json="$(json_array "${input_modalities[@]}")"; fi
if ((${#output_modalities[@]})); then output_json="$(json_array "${output_modalities[@]}")"; fi
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if ((${#force_update[@]})); then
  catalog="$($script_dir/models.sh catalog --force-update --path-only)"
else
  catalog="$($script_dir/models.sh catalog --path-only)"
fi

jq \
  --arg query "$query" \
  --arg provider_id "$provider" \
  --argjson reasoning "$reasoning" \
  --argjson tools "$tools" \
  --argjson structured "$structured_output" \
  --argjson open "$open_weights" \
  --argjson inputs "$input_json" \
  --argjson outputs "$output_json" \
  --arg min_context "$min_context" \
  --arg min_output "$min_output" \
  --arg max_input "$max_input_cost" \
  --arg max_output "$max_output_cost" \
  --arg sort "$sort" \
  --argjson limit "$limit" '
[
  .providers | to_entries[] as $provider_entry
  | $provider_entry.value.models | to_entries[]
  | .value as $model
  | {
      provider: $provider_entry.key,
      model: .key,
      name: $model.name,
      description: $model.description,
      reasoning: $model.reasoning,
      tools: $model.tool_call,
      structured_output: $model.structured_output,
      modalities: $model.modalities,
      open_weights: $model.open_weights,
      context: $model.limit.context,
      max_output: $model.limit.output,
      cost: $model.cost,
      updated: $model.last_updated
    }
  | select($provider_id == "" or .provider == $provider_id)
  | select($query == "" or ([.provider, .model, .name, .description] | map(. // "") | join(" ") | ascii_downcase | contains($query | ascii_downcase)))
  | select(($reasoning | not) or .reasoning == true)
  | select(($tools | not) or .tools == true)
  | select(($structured | not) or .structured_output == true)
  | select(($open | not) or .open_weights == true)
  | . as $candidate
  | select(all($inputs[]; . as $wanted | ($candidate.modalities.input // []) | index($wanted)))
  | select(all($outputs[]; . as $wanted | ($candidate.modalities.output // []) | index($wanted)))
  | select($min_context == "" or (.context != null and .context >= ($min_context | tonumber)))
  | select($min_output == "" or (.max_output != null and .max_output >= ($min_output | tonumber)))
  | select($max_input == "" or (.cost.input != null and .cost.input <= ($max_input | tonumber)))
  | select($max_output == "" or (.cost.output != null and .cost.output <= ($max_output | tonumber)))
]
| sort_by(
    if $sort == "context" then (.context // 0)
    elif $sort == "updated" then (.updated // "")
    elif $sort == "output-cost" then [(.cost.output == null), (.cost.output // 0)]
    else [(.cost.input == null), (.cost.input // 0)]
    end
  )
| if $sort == "context" or $sort == "updated" then reverse else . end
| .[:$limit]
' "$catalog"
