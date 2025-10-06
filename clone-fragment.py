#!/usr/bin/env python3
import argparse
import re
from pathlib import Path
from typing import Iterable, Optional

# --- Patterns to edit inside the fragment ---------------------------------
RE_TARBALL_XQCUT = re.compile(r"(_xqcut)(\d+)(_tarball\.tar\.xz)")
RE_QCUT_LINE     = re.compile(r"(JetMatching:qCut\s*=\s*)(\d+(?:\.\d*)?)")

# Detect run from filename:
# e.g. "ms-Rhadron_mstop_2000-fragment_Jet_matching_ON"
# Look for "-fragment" followed by end/underscore/hyphen
# Fallback: detect run in file contents (typical in tarball URL)
# e.g. ".../RunII/ms-Rhadron_mstop_2000_slc7_amd64_...tarball.tar.xz"
RE_FILENAME_RUN  = re.compile(r"^(?P<run>[^/]+?)-fragment(?=$|[_-])")
RE_RUN_IN_TEXT   = re.compile(r"(ms-[A-Za-z0-9_]+?_\d+)(?=[/_])")


def guess_old_run_from_filename(inp: Path) -> Optional[str]:
    m = RE_FILENAME_RUN.match(inp.stem)
    return m.group("run") if m else None

def guess_old_run_from_text(text: str) -> Optional[str]:
    m = RE_RUN_IN_TEXT.search(text)
    return m.group(1) if m else None

def patch_fragment(text: str, new_qcut: int, old_run: Optional[str], new_run: Optional[str]) -> str:
    out = text

    # run rename (only if both provided)
    if old_run and new_run and old_run != new_run:
        out = out.replace(old_run, new_run)

    # Tarball xqcut
    def _sub_tar(m: re.Match) -> str:
        return f"{m.group(1)}{new_qcut}{m.group(3)}"
    out, _ = RE_TARBALL_XQCUT.subn(_sub_tar, out)

    # Pythia qCut line
    def _sub_q(m: re.Match) -> str:
        return f"{m.group(1)}{new_qcut}."
    out, _ = RE_QCUT_LINE.subn(_sub_q, out)
    return out

def make_name(base: Path, q: int, pattern: str, old_run: Optional[str], new_run: Optional[str]) -> Path:
    stem, ext = base.stem, base.suffix
    if old_run and new_run and old_run != new_run:
        stem = stem.replace(old_run, new_run)
    name = pattern.format(stem=stem, qcut=q, ext=ext)  # default appends __qcut{q}
    return base.with_name(name)

def run(inp: Path, outdir: Path, qcuts: Iterable[int], pattern: str, dry: bool,
        run_rename: Optional[str]) -> None:
    if not inp.is_file():
        raise FileNotFoundError(f"Input fragment not found: {inp}")
    outdir.mkdir(parents=True, exist_ok=True)

    text = inp.read_text()

    # Detect old_run from filename; if not found, try inside the text (tarball URL)
    old_run = guess_old_run_from_filename(inp)
    if run_rename and not old_run:
        old_run = guess_old_run_from_text(text)

    if run_rename and not old_run:
        print("[warn] --run_rename provided, but could not detect the original run token "
              "from filename or contents. Skipping run rename.")
        run_rename = None

    for q in qcuts:
        patched = patch_fragment(text, q, old_run=old_run, new_run=run_rename)
        out_path = outdir / make_name(inp, q, pattern, old_run=old_run, new_run=run_rename).name
        if dry:
            print(f"[dry-run] would write: {out_path}")
        else:
            out_path.write_text(patched)
            print(f"[ok] wrote {out_path}")

def parse_args():
    ap = argparse.ArgumentParser(description="Clone a CMSSW fragment for multiple xqcut values.")
    ap.add_argument("-i", "--in", dest="inp", required=True, help="Path to base fragment (.py)")
    ap.add_argument("-x", "--xqcut", dest="xqcuts", required=True, nargs="+", type=int, help="List of xqcut values, e.g. -x 20 40 60 80 100")
    ap.add_argument("-o", "--outdir", default=None, help="Output directory (default: same directory as input)")
    ap.add_argument("--pattern", default="{stem}__qcut{qcut}{ext}", help="Output filename pattern (default appends __qcut{q})")
    ap.add_argument("--run_rename", dest="run_rename", default=None,help="Rename run token in filename and contents, e.g. ms-Rhadron_mstop_2000 -> ms-Rhadron_mstop_2200")
    ap.add_argument("--run-rename", dest="run_rename_dash", default=None, help=argparse.SUPPRESS)
    ap.add_argument("--dry-run", action="store_true", help="Print actions, don't write files")
    args = ap.parse_args()
    if args.run_rename_dash and not args.run_rename:
        args.run_rename = args.run_rename_dash
    return args

if __name__ == "__main__":
    args = parse_args()
    inp = Path(args.inp).resolve()
    outdir = Path(args.outdir).resolve() if args.outdir else inp.parent
    run(inp, outdir, args.xqcuts, args.pattern, args.dry_run, run_rename=args.run_rename)
