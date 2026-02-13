#!/usr/bin/env python3
import argparse
import gzip
import os
import re
import sys
from datetime import datetime

INIT_OPEN_RE = re.compile(r"<init\b[^>]*>", re.IGNORECASE)
INIT_CLOSE_RE = re.compile(r"</init\s*>", re.IGNORECASE)

def open_maybe_gzip(path):
    # Text mode, universal newlines
    if path.endswith(".gz"):
        return gzip.open(path, "rt", encoding="utf-8", errors="replace")
    return open(path, "rt", encoding="utf-8", errors="replace")

def extract_init_blocks(path):
    blocks = []
    buf = []
    in_block = False

    with open_maybe_gzip(path) as f:
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

    # If file ended while still inside a block, treat as an error
    if in_block:
        raise RuntimeError(f"Found <init> in {path} but never found </init>")

    return blocks

def main():
    ap = argparse.ArgumentParser(
        description="Extract <init>...</init> blocks from LHE files and append to a text file."
    )
    ap.add_argument("inputs", nargs="+", help="Input LHE file(s): .lhe or .lhe.gz")
    ap.add_argument(
        "-o", "--out", default="init_blocks.txt",
        help="Output text file to append to (default: init_blocks.txt)"
    )
    ap.add_argument(
        "--no-header", action="store_true",
        help="Do not write file header separators in the output."
    )
    args = ap.parse_args()

    wrote_any = False

    with open(args.out, "a", encoding="utf-8") as out:
        for inp in args.inputs:
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
                    out.write(f"# file: {os.path.abspath(inp)}\n")
                    out.write(f"# time: {ts}\n")
                    out.write(f"# block: {i} of {len(blocks)}\n")
                    out.write("#" * 80 + "\n")
                out.write(block)
                # Ensure a trailing newline between blocks
                if not block.endswith("\n"):
                    out.write("\n")

            wrote_any = True

    if not wrote_any:
        return 2
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
