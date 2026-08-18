<div align="center">
  <h1><strong>Study Anything</strong></h1>
  <p><strong>A reusable learning-coach skill for building durable understanding.</strong></p>
  <p>
    <strong>English</strong> · <a href="./README.zh-CN.md">简体中文</a>
  </p>
  <p>
    <img alt="Version 0.1.0" src="https://img.shields.io/badge/version-0.1.0-0f766e?style=flat-square">
    <img alt="License 0BSD" src="https://img.shields.io/badge/license-0BSD-2563eb?style=flat-square">
    <img alt="Skill package" src="https://img.shields.io/badge/package-skill.zip-334155?style=flat-square">
    <img alt="Reproducible SHA-256" src="https://img.shields.io/badge/SHA--256-reproducible-7c3aed?style=flat-square">
  </p>
</div>

`study-anything` helps an agent guide a learner from unfamiliarity to transferable understanding. It combines calibration, active recall, concrete explanations, guided practice, and review in one self-contained skill package.

It is product-neutral and does not depend on a particular provider, database, or deployment environment.

## At a Glance

| Item | Details |
| --- | --- |
| Package key | `study-anything` |
| Full instructions | `SKILL.md` |
| Concise runtime | `runtime.md` |
| Operating modes | Ordinary conversation and structured JSON |
| Public contracts | `study_context_v1` → `study_decision_v1` |
| Release artifact | `dist/study-anything.skill.zip` |
| License | 0BSD |

## What It Improves

- Calibrates the learner's goal, level, constraints, and familiar domains before planning.
- Uses analogies only when the learner confirms the source domain and always states the boundary.
- Creates focused learning plans instead of oversized curricula.
- Protects review gates and favors retrieval-based questions over passive explanation.
- Uses Socratic prompts and Feynman explanations to test transferable understanding.
- Ends every learner-facing turn with a concrete next action.

## Learning Flow

| Stage | Purpose |
| --- | --- |
| 1. Calibrate | Understand the goal, current level, constraints, and useful reference domains. |
| 2. Plan | Build a small, focused learning path with clear unit objectives. |
| 3. Practice | Ask the learner to predict, compare, retrieve, explain, and apply. |
| 4. Review | Revisit prior material with short, targeted recall checks. |
| 5. Transfer | Use a Feynman explanation and a fresh example before treating a unit as understood. |

## Quick Start

Copy this repository into the skill directory used by your agent runtime, or point the runtime directly at `SKILL.md`.

```text
study-anything/
├── SKILL.md
├── runtime.md
├── package.yaml
└── examples/
```

For ordinary conversations, load `SKILL.md`. No application-specific payload is required.

## Structured Integration

Host applications can load the concise `runtime.md` prompt and provide a `study_context_v1` payload. The skill returns one `study_decision_v1` object with learner-facing text, suggested state changes, and an optional bounded analogy record.

See [docs/runtime-contract.md](docs/runtime-contract.md) for the full public contract. The host remains responsible for persistence, authorization, and final validation.

## Build and Validate

Requirements: `bash`, `jq`, `zip`, `shasum`, `awk`, `find`, `sort`, and `touch`.

```bash
./scripts/validate-package.sh
./scripts/build-zip.sh
```

Generated files:

```text
dist/study-anything.skill.zip
dist/study-anything.skill.zip.sha256
```

The archive uses a sorted file list and fixed timestamps, so the same source produces the same SHA-256 checksum.

## Repository Layout

```text
SKILL.md                          Full skill instructions
runtime.md                        Concise structured runtime
package.yaml                      Package manifest
README.zh-CN.md                   Simplified Chinese documentation
docs/runtime-contract.md          Structured input/output contract
docs/package-notes.md             Packaging and boundary notes
examples/                         Structured-mode examples
scripts/                          Validation and reproducible packaging
dist/                             Ready-to-publish zip and checksum
```

## Design Principle

The learner should do meaningful thinking. A short question, comparison, prediction, or micro task is preferred when it reveals understanding more efficiently than a long explanation. Familiar-domain analogies are optional and bounded; concrete examples remain the default when no useful reference domain is available.

## License

Released under the [0BSD License](LICENSE).
