#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKG_DIR="${ROOT_DIR}"

for cmd in jq find grep; do
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "missing required command: ${cmd}" >&2
    exit 1
  fi
done

required_files=(
  "SKILL.md"
  "runtime.md"
  "package.yaml"
  "README.md"
  "README.zh-CN.md"
  "LICENSE"
  "CHANGELOG.md"
  "docs/runtime-contract.md"
  "docs/package-notes.md"
  "examples/calibration-missing-familiar-domain.json"
  "examples/no-familiar-domain.json"
  "scripts/validate-package.sh"
  "scripts/build-zip.sh"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "${PKG_DIR}/${file}" ]]; then
    echo "missing required file: ${file}" >&2
    exit 1
  fi
done

if ! grep -q 'README.zh-CN.md' "${PKG_DIR}/README.md"; then
  echo "README.md is missing the Chinese documentation link" >&2
  exit 1
fi

if ! grep -q 'README.md' "${PKG_DIR}/README.zh-CN.md"; then
  echo "README.zh-CN.md is missing the English documentation link" >&2
  exit 1
fi

install_source="github.com/konglong87/study-anything"
for readme in "README.md" "README.zh-CN.md"; do
  if ! grep -q "${install_source}" "${PKG_DIR}/${readme}"; then
    echo "${readme} is missing the one-line install source" >&2
    exit 1
  fi
  for agent in "Codex" "Claude Code" "Trae" "WorkBuddy" "OpenCode"; do
    if ! grep -q "${agent}" "${PKG_DIR}/${readme}"; then
      echo "${readme} is missing install guidance for ${agent}" >&2
      exit 1
    fi
  done
done

if ! grep -q '^package_key: study-anything$' "${PKG_DIR}/package.yaml"; then
  echo "package.yaml has an unexpected package_key" >&2
  exit 1
fi

if ! grep -q '^entrypoint: SKILL.md$' "${PKG_DIR}/package.yaml"; then
  echo "package.yaml has an unexpected entrypoint" >&2
  exit 1
fi

for marker in "study-anything" "study_context_v1" "study_decision_v1" "Calibration" "Feynman"; do
  if ! grep -q "${marker}" "${PKG_DIR}/SKILL.md" "${PKG_DIR}/runtime.md"; then
    echo "package instructions missing required marker: ${marker}" >&2
    exit 1
  fi
done

if find "${PKG_DIR}" -type l | grep -q .; then
  echo "package must not contain symlinks" >&2
  exit 1
fi

while IFS= read -r file; do
  rel="${file#${PKG_DIR}/}"
  case "${rel}" in
    .git/*|dist/*|.gitignore)
      continue
      ;;
  esac
  case "${rel}" in
    *.md|*.json|*.yaml|*.yml|*.txt|*.sh|LICENSE)
      ;;
    *)
      echo "unsupported package file extension: ${rel}" >&2
      exit 1
      ;;
  esac
done < <(find "${PKG_DIR}" -type f | LC_ALL=C sort)

for sample in "${PKG_DIR}"/examples/*.json; do
  jq empty "${sample}"
done

echo "study-anything package validation passed"
