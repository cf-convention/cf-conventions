#!/usr/bin/env python
"""
Simple quick and dirty script that strips whitesapce from the ends of lines

Requires Python (> 3.10? tested on 3.14, but nothing exotic is used)
"""

import sys

USAGE = """Script to strip the whitespace from the ends of lines in a file

usage: scripts/strip_whitespace.py [files]

Example: ./strip_whitespace.py *.adoc
"""

def main():
    infiles = sys.argv[1:]
    if not infiles:
        print(USAGE)
        sys.exit(1)
    for filename in infiles:
        print(f"Stripping: {filename}")
        with open(filename) as the_file:
            lines = the_file.readlines()
        with open(filename, 'w') as the_file:
            for line in lines:
                the_file.write(line.rstrip() + '\n')



if __name__ == "__main__":
    main()
