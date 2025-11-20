#!/bin/bash
set -euo pipefail

MACRO="/uscms/home/avendras/nobackup/HSCP/genproductions/bin/MadGraph5_aMCatNLO/macros/plotdjr.C"
DEST="/uscms/home/avendras/nobackup/HSCP/DRJ_plots"

usage() {
  echo "Usage: ${0##*/} -d DIR"
  echo "  -d, --dir   Directory containing .root files (flat scan; skips *\"_inLHE.root\")"
  echo "  -h, --help  Show this help"
}

INDIR=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -d|--dir) INDIR="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1"; usage; exit 2 ;;
  esac
done

[[ -n "${INDIR}" ]] || { echo "ERROR: -d/--dir is required"; usage; exit 2; }
[[ -d "${INDIR}" ]] || { echo "ERROR: directory not found: ${INDIR}"; exit 1; }
[[ -f "${MACRO}" ]] || { echo "ERROR: macro not found: ${MACRO}"; exit 1; }
command -v root >/dev/null || { echo "ERROR: 'root' not found in PATH. Did you cmsenv?"; exit 1; }

mkdir -p "${DEST}"
shopt -s nullglob

echo "==> Input dir: ${INDIR}"
echo "==> Output base: ${DEST}"
echo "==> Macro: ${MACRO}"
echo

count=0
for f in "${INDIR}"/*.root; do
  [[ -e "$f" ]] || break
  [[ "$f" == *_inLHE.root ]] && continue

  base="$(basename "${f%.root}")"
  grp_token="$(basename "$base" | grep -Eo 'ms_Rhadron_mstop[-_][0-9]+' | head -n1 || true)"
  #if found, replace the hyphen before the mass with underscore; else fall back to 'misc'
  if [[ -n "$grp_token" ]]; then
    group="${grp_token/-/_}"
  else
    group="misc"
  fi

  outdir="${DEST}/${group}"
  mkdir -p "${outdir}"

  outpdf="${outdir}/${base}_DJR.pdf"
  echo "Plotting: $(basename "$f")  ->  ${outpdf}"
  root -l -b -q "${MACRO}(\"${f}\",\"${outpdf}\")" </dev/null

  ((count++)) || true
done

if (( count == 0 )); then
  echo "No matching *.root files found (after excluding *_inLHE.root)."
else
  echo "Done. Created ${count} PDF(s). Outputs under: ${DEST}"
fi
