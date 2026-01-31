#!/bin/bash
set -euo pipefail

MACRO="/uscms/home/avendras/nobackup/HSCP/genproductions/bin/MadGraph5_aMCatNLO/macros/plotdjr.C"
DEST="/uscms/home/avendras/nobackup/HSCP/DJR_plots"

usage() {
  echo "Usage:"
  echo "  ${0##*/} -d DIR            # scan DIR/*.root (skips *_inLHE.root)"
  echo "  ${0##*/} -f FILE.root      # plot a single file"
  echo "  ${0##*/} FILE1.root ...    # plot one or more files"
  echo "Options:"
  echo "  -d, --dir   Directory containing .root files (flat scan; skips *\"_inLHE.root\")"
  echo "  -f, --file  Single .root file"
  echo "  -h, --help  Show this help"
}

INDIR=""
INFILE=""
FILES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    -d|--dir)  INDIR="${2:-}"; shift 2 ;;
    -f|--file) INFILE="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    --) shift; FILES+=("$@"); break ;;
    -*)
      echo "Unknown arg: $1"
      usage
      exit 2
      ;;
    *)
      FILES+=("$1")
      shift
      ;;
  esac
done

# Validate inputs
if [[ -n "${INDIR}" && ( -n "${INFILE}" || ${#FILES[@]} -gt 0 ) ]]; then
  echo "ERROR: Use either -d/--dir OR file input(s), not both."
  usage
  exit 2
fi

if [[ -n "${INFILE}" ]]; then
  FILES+=("${INFILE}")
fi

if [[ -n "${INDIR}" ]]; then
  [[ -d "${INDIR}" ]] || { echo "ERROR: directory not found: ${INDIR}"; exit 1; }
  shopt -s nullglob
  for f in "${INDIR}"/*.root; do
    [[ "$f" == *_inLHE.root ]] && continue
    FILES+=("$f")
  done
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "ERROR: No input provided. Use -d DIR or -f FILE.root or pass files as arguments."
  usage
  exit 2
fi

[[ -f "${MACRO}" ]] || { echo "ERROR: macro not found: ${MACRO}"; exit 1; }
command -v root >/dev/null || { echo "ERROR: 'root' not found in PATH. Did you cmsenv?"; exit 1; }

mkdir -p "${DEST}"

echo "==> Output base: ${DEST}"
echo "==> Macro: ${MACRO}"
echo

count=0
for f in "${FILES[@]}"; do
  [[ -f "$f" ]] || { echo "WARN: skipping missing file: $f"; continue; }
  [[ "$f" == *_inLHE.root ]] && { echo "SKIP (inLHE): $(basename "$f")"; continue; }

  base="$(basename "${f%.root}")"
  grp_token="$(basename "$base" | grep -Eo 'ms_Rhadron_mstop[-_][0-9]+' | head -n1 || true)"
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
  echo "No matching ROOT files plotted (missing/skipped)."
else
  echo "Done. Created ${count} PDF(s). Outputs under: ${DEST}"
fi
