# Study Anything

`study-anything` is a reusable learning-coach skill for agents and host applications. It helps a learner move from unfamiliarity to durable understanding through calibration, active recall, concrete explanations, guided practice, and review.

The package is intentionally self-contained. It does not depend on a particular product, provider, database, or deployment environment.

## What It Does

- calibrates goals, level, constraints, and familiar reference domains;
- uses analogies only when the learner confirms the source domain;
- creates focused learning plans instead of oversized curricula;
- protects review gates and uses retrieval-based questions;
- applies Socratic prompts and Feynman explanations;
- gives a clear next action after every learner-facing turn;
- supports both ordinary conversation and a small structured JSON contract.

## Use It

Copy this directory into the skill directory used by your agent runtime, or point the runtime at `SKILL.md`.

For a host application, use `runtime.md` as the concise request-time prompt and provide a `study_context_v1` payload. The companion `docs/runtime-contract.md` describes the public structured contract. The host owns persistence, authorization, and final validation; this package provides teaching behavior and suggested state changes.

## Build and Validate

Requirements: `bash`, `jq`, `zip`, `shasum`, `awk`, `find`, `sort`, and `touch`.

```bash
./scripts/validate-package.sh
./scripts/build-zip.sh
```

The build creates:

```text
dist/study-anything.skill.zip
dist/study-anything.skill.zip.sha256
```

The archive is assembled from a sorted file list with fixed timestamps, so the checksum is reproducible from the same source. The checksum file uses standard two-column format and can be attached to a release.

## Package Layout

```text
SKILL.md                         Full skill instructions
runtime.md                       Concise runtime instructions
docs/runtime-contract.md         Structured input/output contract
docs/package-notes.md            Packaging and boundary notes
examples/                        Small structured-mode examples
scripts/                         Validation and reproducible packaging tools
```

## Design Principles

The learner should do meaningful thinking. Explanations are short when a question, comparison, prediction, or small task can reveal understanding more efficiently. Familiar-domain analogies are optional and bounded: concrete examples remain the default when no useful reference domain is available.

## License

0BSD. See [LICENSE](LICENSE).
