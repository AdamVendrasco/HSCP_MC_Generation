#!/usr/bin/env python3
import argparse
import os
import re
import sys
from datetime import datetime

INIT_OPEN_RE = re.compile(r"<init\b[^>]*>", re.IGNORECASE)
INIT_CLOSE_RE = re.compile(r"</init\s*>", re.IGNORECASE)

def extract_init_blocks(path: str):
    blocks = []
    buf = []
    in_block = False

    with open(path, "rt", encoding="utf-8", errors="replace") as f:
        for line in f:
            if not in_block:
                if INIT_OPEN_RE.search(line):
                    in_block = True
                    buf = [line]
            else:
                buf.append(line)
                if INIT_CLOSE_RE.search(line):
                    blocks.append("".join(buf))
                    buf = []
                    in_block = False

    if in_block:
        raise RuntimeError(f"Found <init> in {path} but never found </init>")

    return blocks

def iter_lhe_files(paths, recursive: bool):
    """
    Yield .lhe files found in:
      - explicit file paths
      - directory paths (walked if recursive)
    """
    for p in paths:
        if os.path.isfile(p):
            if p.lower().endswith(".lhe"):
                yield os.path.abspath(p)
            continue

        if os.path.isdir(p):
            if recursive:
                for root, _, files in os.walk(p):
                    for name in files:
                        if name.lower().endswith(".lhe"):
                            yield os.path.abspath(os.path.join(root, name))
            else:
                for name in os.listdir(p):
                    full = os.path.join(p, name)
                    if os.path.isfile(full) and name.lower().endswith(".lhe"):
                        yield os.path.abspath(full)
            continue

        print(f"[WARN] Skipping (not found): {p}", file=sys.stderr)

def main():
    ap = argparse.ArgumentParser(
        description="Extract <init>...</init> blocks from LHE files and append to a text file."
    )
    ap.add_argument(
        "paths",
        nargs="+",
        help="Input file(s) or directory(ies). Directories will be scanned for .lhe files.",
    )
    ap.add_argument(
        "-o", "--out",
        default="init_blocks.txt",
        help="Output text file to append to (default: init_blocks.txt)"
    )
    ap.add_argument(
        "--no-header",
        action="store_true",
        help="Do not write file header separators in the output."
    )
    ap.add_argument(
        "-r", "--recursive",
        action="store_true",
        help="Recursively scan directories."
    )
    ap.add_argument(
        "--sort",
        action="store_true",
        help="Sort discovered files for stable output order."
    )

    args = ap.parse_args()

    files = list(iter_lhe_files(args.paths, recursive=args.recursive))
    if args.sort:
        files.sort()

    if not files:
        print("[ERROR] No .lhe files found in the provided path(s).", file=sys.stderr)
        return 2

    wrote_any = False

    with open(args.out, "a", encoding="utf-8") as out:
        for inp in files:
            try:
                blocks = extract_init_blocks(inp)
            except Exception as e:
                print(f"[ERROR] {inp}: {e}", file=sys.stderr)
                continue

            if not blocks:
                print(f"[WARN] {inp}: no <init> block found", file=sys.stderr)
                continue

            for i, block in enumerate(blocks, start=1):
                if not args.no_header:
                    ts = datetime.now().isoformat(timespec="seconds")
                    out.write("\n")
                    out.write("#" * 80 + "\n")
                    out.write(f"# file: {inp}\n")
                    out.write(f"# time: {ts}\n")
                    out.write(f"# block: {i} of {len(blocks)}\n")
                    out.write("#" * 80 + "\n")

                out.write(block)
                if not block.endswith("\n"):
                    out.write("\n")

            wrote_any = True

    return 0 if wrote_any else 2

if __name__ == "__main__":
    raise SystemExit(main())
