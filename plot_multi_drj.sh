#!/usr/bin/env bash
set -euo pipefail

MACRO="/uscms/home/avendras/nobackup/HSCP/genproductions/bin/MadGraph5_aMCatNLO/macros/plotdjr.C"
BASE="/uscms/home/avendras/nobackup/HSCP/run_directories"
DEST="/uscms/home/avendras/nobackup/HSCP/DRJ_plots"

# Only these three mass points
TARGETS=(
  "ms-Rhadron_mstop_700"
  "ms-Rhadron_mstop_1000"
  "ms-Rhadron_mstop_2000"
)

mkdir -p "$DEST"
shopt -s nullglob

# ---- NEW: optional single-file mode flags ----
INFILE=""
RUNNAME=""

usage() {
  echo "Usage:"
  echo "  ${0##*/}                        # batch mode over TARGETS (original behavior)"
  echo "  ${0##*/} -in FILE.root [-r RUN] # single file -> \$DEST/RUN/<file>_DJR.pdf"
  echo
  echo "Options:"
  echo "  -in, --in        Path to a single ROOT file"
  echo "  -r,  --run-name  Subdir name under \$DEST (default: derived from FILE path)"
  echo "  -h,  --help      Show this message"
}

# minimal arg parsing
while [[ $# -gt 0 ]]; do
  case "$1" in
    -in|--in)      INFILE="${2:-}"; shift 2 ;;
    -r|--run-name) RUNNAME="${2:-}"; shift 2 ;;
    -h|--help)     usage; exit 0 ;;
    *) echo "Unknown arg: $1"; usage; exit 2 ;;
  esac
done

plot_one() {
  local f="$1"
  local run="$2"
  mkdir -p "$DEST/$run"
  local base
  base="$(basename "${f%.root}")"
  local out="${DEST}/${run}/${base}_DJR.pdf"
  echo "Plotting: $(basename "$f")  -->  ${out}"
  root -l -b -q "${MACRO}(\"${f}\",\"${out}\")" </dev/null
}

# ---- Single-file mode (short-circuit) ----
if [[ -n "$INFILE" ]]; then
  [[ -f "$INFILE" ]] || { echo "Input file not found: $INFILE" >&2; exit 1; }

  if [[ -z "$RUNNAME" ]]; then
    parent="$(basename "$(dirname "$INFILE")")"
    if [[ "$parent" == "root_files" ]]; then
      RUNNAME="$(basename "$(dirname "$(dirname "$INFILE")")")"
    else
      RUNNAME="$parent"
    fi
  fi

  echo "==> Single-file mode"
  echo "Input: $INFILE"
  echo "Run name: $RUNNAME"
  echo "Output dir: $DEST/$RUNNAME"
  plot_one "$INFILE" "$RUNNAME"
  echo "Done. PDF in: $DEST/$RUNNAME"
  exit 0
fi

# ---- Original batch behavior (unchanged) ----
for t in "${TARGETS[@]}"; do
  rf="${BASE}/${t}/root_files"
  [[ -d "$rf" ]] || { echo "Skip (no dir): $rf"; continue; }

  outdir="$DEST/$t"
  mkdir -p "$outdir"
  echo "==> Scanning: $rf  →  Output: $outdir"

  for f in "$rf"/*.root; do
    [[ "$f" == *_inLHE.root ]] && continue
    base="$(basename "${f%.root}")"
    out="${outdir}/${base}_DJR.pdf"
    echo "Plotting: $(basename "$f")  -->  ${out}"
    root -l -b -q "${MACRO}(\"${f}\",\"${out}\")" </dev/null
  done
done

echo "All done. PDFs in: $DEST"
