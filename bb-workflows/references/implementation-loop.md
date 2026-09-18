TODO
                          │
                          ▼
                     ┌─────────┐
                     │  PARSE  │
                     └────┬────┘
                          │
                  validate schema
                          │
                          ▼
                     ┌─────────┐
                     │  SPEC   │
                     └────┬────┘
                          │
              conflict ───┴───► ESCALATE
                          │
                          ▼
                   ┌─────────────┐
                   │ PREFLIGHT   │
                   └──────┬──────┘
                          │
                 blocked ─┴─────► BLOCKED
                          │
                          ▼
                   ┌─────────────┐
                   │ LOCALIZE    │
                   └──────┬──────┘
                          │
                          ▼
                     ┌─────────┐
                     │  PLAN   │
                     └────┬────┘
                          │
                   validate plan
                          │
                          ▼
                ┌───────────────────┐
                │ IMPLEMENT STEP N  │
                └────────┬──────────┘
                         │
                         ▼
                ┌───────────────────┐
                │ POLICY CHECK      │◄── deterministic
                └────────┬──────────┘
                         │
                         ▼
                ┌───────────────────┐
                │ VERIFY STEP       │◄── deterministic
                └────────┬──────────┘
                         │
               ┌─────────┴───────────┐
               │                     │
             PASS                  FAIL
               │                     │
               │                     ▼
               │                 TRIAGE
               │          ┌──────────┼──────────┐
               │          │          │          │
               │        REPAIR    DIAGNOSE   BLOCK/
               │          │          │       ESCALATE
               │          └────┬─────┘
               │               │
               │               └────────► VERIFY
               │
               ▼
          more steps?
            │     │
           yes    no
            │     │
            └─────┘
                  │
                  ▼
          ┌────────────────┐
          │ FULL VERIFY    │
          └───────┬────────┘
                  │
                  ▼
          ┌────────────────┐
          │ FRESH REVIEW   │
          └───────┬────────┘
                  │
            ┌─────┴──────┐
            │            │
           PASS         FAIL
            │            │
            ▼            ▼
        COMPLETE       TRIAGE
                         │
                         ▼
                       REPAIR
                         │
                         ▼
                    FULL VERIFY
                         │
                         └────► REVIEW
