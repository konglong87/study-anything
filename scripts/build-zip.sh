#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKG_DIR="${ROOT_DIR}"
DIST_DIR="${ROOT_DIR}/dist"
ZIP_PATH="${DIST_DIR}/study-anything.skill.zip"

for cmd in awk find sort zip shasum touch cp mkdir; do
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "missing required command: ${cmd}" >&2
    exit 1
  fi
done

"${PKG_DIR}/scripts/validate-package.sh"

mkdir -p "${DIST_DIR}"
rm -f "${ZIP_PATH}" "${ZIP_PATH}.sha256"

stage_dir="$(mktemp -d "${TMPDIR:-/tmp}/study-anything-package.XXXXXX")"
cleanup() {
  rm -rf "${stage_dir}"
}
trap cleanup EXIT

while IFS= read -r rel; do
  case "${rel}" in
    ./.git/*|./dist/*|./.gitignore)
      continue
      ;;
  esac
  rel="${rel#./}"
  mkdir -p "${stage_dir}/$(dirname "${rel}")"
  cp "${PKG_DIR}/${rel}" "${stage_dir}/${rel}"
done < <(cd "${PKG_DIR}" && find . -type f | LC_ALL=C sort)

find "${stage_dir}" -type f -exec touch -t 202601010000 {} +
(
  cd "${stage_dir}"
  find . -type f | LC_ALL=C sort | zip -X -q "${ZIP_PATH}" -@
)

checksum="$(LC_ALL=C LANG=C shasum -a 256 "${ZIP_PATH}" | awk '{print $1}')"
printf '%s  %s\n' "${checksum}" "$(basename "${ZIP_PATH}")" >"${ZIP_PATH}.sha256"
echo "wrote ${ZIP_PATH}"
echo "wrote ${ZIP_PATH}.sha256"
printf '%s  %s\n' "${checksum}" "${ZIP_PATH}"
