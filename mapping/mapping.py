#!/usr/bin/env python3
import csv
import sys

def load_mapping(csv_path):
    m = {}
    with open(csv_path, newline='') as f:
        reader = csv.reader(f)
        next(reader, None)           # skip header
        for row in reader:
            # we now expect at least 3 columns: PDGID, oldName, newName, [mass]
            if len(row) < 3:
                continue
            old, new = row[1].strip(), row[2].strip()
            if old and new:
                m[old] = new
    return m

def transcribe(input_path, output_path, mapping):
    # sort by length (longest first)
    keys = sorted(mapping.keys(), key=len, reverse=True)

    with open(input_path, 'r') as fin, open(output_path, 'w') as fout:
        for line in fin:
            for old in keys:
                line = line.replace(old, mapping[old])
            fout.write(line)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: mapping.py mapping.csv input.txt output.txt")
        sys.exit(1)

    map_csv, in_txt, out_txt = sys.argv[1:]
    mapping = load_mapping(map_csv)
    if not mapping:
        print(f"Error: no valid mappings found in {map_csv}", file=sys.stderr)
        sys.exit(1)

    transcribe(in_txt, out_txt, mapping)
    print(f"Wrote transformed file to {out_txt}")
