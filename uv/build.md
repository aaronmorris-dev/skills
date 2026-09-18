# uv Build Backend

For a new pure Python package, consider `uv_build`; preserve an existing backend unless a migration is requested. Native extension builds need an appropriate supported backend for their actual toolchain; do not assume that changing to `hatchling` alone provides compilation. The example version range is illustrative, not a current-version recommendation.

## pyproject.toml

```toml
[project]
name = "my-package"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = []

[build-system]
requires = ["uv_build>=0.9.28,<0.10.0"]
build-backend = "uv_build"
```

## Project Structure

Default layout uses `src/<package_name>/__init__.py`:

```
pyproject.toml
src/
└── my_package/
    └── __init__.py
```

Package name is normalized: `Foo-Bar` → `foo_bar`.

### Custom Module Location

```toml
[tool.uv.build-backend]
module-name = "mymodule"
module-root = ""  # Use project root instead of src/
```

### Namespace Packages

For `foo.bar` namespace:

```
src/foo/bar/__init__.py  # No __init__.py in foo/
```

```toml
[tool.uv.build-backend]
module-name = "foo.bar"
```

## File Inclusion/Exclusion

Excludes `__pycache__`, `*.pyc`, `*.pyo` by default.

```toml
[tool.uv.build-backend]
source-include = ["assets/**"]
source-exclude = ["/dist", "tests/**"]
```

- Includes are anchored (`pyproject.toml` = only root)
- Excludes are not anchored (`__pycache__` = all dirs named that)
- Use `/prefix` to anchor excludes
