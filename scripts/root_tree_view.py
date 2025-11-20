#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys, argparse
import ROOT
ROOT.gROOT.SetBatch(True)

def connector(prefix: str, is_last: bool) -> str:
    return prefix + ("└── " if is_last else "├── ")

def next_prefix(prefix: str, is_last: bool) -> str:
    return prefix + ("    " if is_last else "│   ")

def print_tree_header(name, entries=None, prefix=""):
    extra = f"  ({entries} entries)" if entries is not None else ""
    print(prefix + name + extra)

def list_keys_sorted(tdir):
    keys = list(tdir.GetListOfKeys()) if tdir and tdir.GetListOfKeys() else []
    # sort by name for stable output
    keys.sort(key=lambda k: k.GetName())
    return keys

def print_leaves(branch, prefix, show_types=True):
    leaves = branch.GetListOfLeaves()
    n = leaves.GetEntries() if leaves else 0
    for i in range(n):
        leaf = leaves.At(i)
        lname = leaf.GetName()
        ltype = leaf.GetTypeName() if show_types else ""
        txt = f"Leaf {lname}" + (f"  [{ltype}]" if ltype else "")
        print(connector(prefix, i == n-1) + txt)

def branch_class_name(br):
    # Try to obtain a meaningful class name when available
    cls = ""
    try:
        cls = br.GetClassName()  # works for split branches / TBranchElement
    except Exception:
        pass
    if not cls:
        # fallback: TBranch::GetTitle sometimes carries the type
        try:
            title = br.GetTitle()
            # Titles in EDM often look like 'edm::Wrapper<...>'
            if "Wrapper" in title or "::" in title:
                cls = title
        except Exception:
            pass
    return cls

def print_branch_recursive(br, prefix, show_types, show_leaves, depth_left):
    cls = branch_class_name(br)
    hdr = f"Branch {br.GetName()}" + (f"  [{cls}]" if cls else "")
    # If this branch has sub-branches (split class), recurse; else show leaves
    sub = br.GetListOfBranches()
    has_sub = bool(sub and sub.GetEntries())
    if not has_sub or depth_left == 0:
        print(connector(prefix, True) + hdr)
        if show_leaves:
            print_leaves(br, next_prefix(prefix, True), show_types)
        return
    # Print branch header and descend into children
    print(connector(prefix, True) + hdr)
    children = [sub.At(i) for i in range(sub.GetEntries())]
    for j, child in enumerate(children):
        last = (j == len(children) - 1)
        # print child with its own header; then recurse further if needed
        child_prefix = next_prefix(prefix, True)
        # Show child name
        ccls = branch_class_name(child)
        chead = f"Branch {child.GetName()}" + (f"  [{ccls}]" if ccls else "")
        print(connector(child_prefix, last) + chead)
        # Recurse one more level into child's children
        gchildren = child.GetListOfBranches()
        if gchildren and gchildren.GetEntries() and depth_left > 1:
            gc_prefix = next_prefix(child_prefix, last)
            for k in range(gchildren.GetEntries()):
                gg = gchildren.At(k)
                gg_last = (k == gchildren.GetEntries() - 1)
                print_branch_recursive(gg, gc_prefix, show_types, show_leaves, depth_left - 2)
        else:
            # If no more sub-branches, optionally show leaves
            if show_leaves:
                print_leaves(child, next_prefix(child_prefix, last), show_types)

def print_ttree(ttree, prefix, filt, show_types, show_leaves, max_branches, depth):
    print_tree_header(ttree.GetName(), entries=ttree.GetEntries(), prefix=prefix)
    branches = ttree.GetListOfBranches()
    if not branches:
        return
    # Collect & filter branches
    brs = [branches.At(i) for i in range(branches.GetEntries())]
    if filt:
        fl = filt.lower()
        brs = [b for b in brs if fl in b.GetName().lower()]
    # Sort by name
    brs.sort(key=lambda b: b.GetName())
    if max_branches is not None:
        brs = brs[:max_branches]

    for idx, br in enumerate(brs):
        # Each top-level branch is printed as a child of the tree
        bprefix = next_prefix(prefix, idx == len(brs) - 1)
        # If the branch itself has children, we’ll handle inside; else print and leaves
        sub = br.GetListOfBranches()
        has_sub = bool(sub and sub.GetEntries())
        # Header line for branch
        bcls = branch_class_name(br)
        bhead = f"Branch {br.GetName()}" + (f"  [{bcls}]" if bcls else "")
        print(connector(prefix, idx == len(brs) - 1) + bhead)
        if has_sub and depth != 0:
            # Recurse into its children
            children = [sub.At(j) for j in range(sub.GetEntries())]
            for j, ch in enumerate(children):
                last = (j == len(children) - 1)
                chcls = branch_class_name(ch)
                chead = f"Branch {ch.GetName()}" + (f"  [{chcls}]" if chcls else "")
                print(connector(bprefix, last) + chead)
                # One more level or show leaves
                gchildren = ch.GetListOfBranches()
                if gchildren and gchildren.GetEntries() and (depth is None or depth > 1):
                    gc_prefix = next_prefix(bprefix, last)
                    for k in range(gchildren.GetEntries()):
                        gg = gchildren.At(k)
                        gg_last = (k == gchildren.GetEntries() - 1)
                        print_branch_recursive(gg, gc_prefix, show_types, show_leaves, (depth - 2) if depth else 0)
                else:
                    if show_leaves:
                        print_leaves(ch, next_prefix(bprefix, last), show_types)
        else:
            # No sub-branches; just show leaves
            if show_leaves:
                print_leaves(br, bprefix, show_types)

def print_directory_recursive(tdir, prefix, filt, show_types, show_leaves, max_branches, depth):
    keys = list_keys_sorted(tdir)
    for i, key in enumerate(keys):
        last = (i == len(keys) - 1)
        cname = key.GetClassName()
        kname = key.GetName()
        hdr = f"{kname}  [{cname}]"
        print(connector(prefix, last) + hdr)
        obj = key.ReadObj()
        if obj.InheritsFrom("TDirectory"):
            print_directory_recursive(obj, next_prefix(prefix, last), filt, show_types, show_leaves, max_branches, depth)
        elif obj.InheritsFrom("TTree"):
            print_ttree(obj, next_prefix(prefix, last), filt, show_types, show_leaves, max_branches, depth)

def main():
    ap = argparse.ArgumentParser(description="Print ROOT file structure (ASCII tree) including EDM trees/branches/leaves.")
    ap.add_argument("input_file", help="ROOT/EDM file path or XRootD URL")
    ap.add_argument("--filter", "-f", default="", help="Substring filter for branch names (case-insensitive)")
    ap.add_argument("--no-types", action="store_true", help="Don’t show class/type names")
    ap.add_argument("--no-leaves", action="store_true", help="Don’t list leaves (only branches)")
    ap.add_argument("--max-branches", type=int, default=None, help="Limit number of branches per tree")
    ap.add_argument("--depth", type=int, default=2, help="How deep to recurse into split branches (default: 2)")
    args = ap.parse_args()

    path = args.input_file
    f = ROOT.TFile.Open(path)
    if not f or f.IsZombie():
        print(f"[ERROR] Could not open: {path}")
        sys.exit(1)

    print_tree_header(f.GetName())
    print_directory_recursive(
        f, prefix="",
        filt=args.filter.strip() or None,
        show_types=(not args.no_types),
        show_leaves=(not args.no_leaves),
        max_branches=args.max_branches,
        depth=args.depth if args.depth is not None else 0
    )
    f.Close()

if __name__ == "__main__":
    main()

