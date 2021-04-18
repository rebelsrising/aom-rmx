#!/usr/bin/env python3

import argparse
import os
import re

parser = argparse.ArgumentParser(description='Compiles multiple XS sources into one.')
parser.add_argument('src_path', type=str, help='path to the map file (or folder of .xs files) with dependencies')
parser.add_argument('--deps_path', '-d', type=str, nargs='?', default='',
                    help='the path of the dependencies (defaults to src_path)')
parser.add_argument('--out_path', '-o', type=str, nargs='?', default='out',
                    help='folder to place the compiled files in (defaults to out/')

args = parser.parse_args()


def get_dependencies(src_path, deps_path):
    # Read file.
    f = open(src_path)
    rms = f.read()
    f.close()

    # Preprocess.
    rms = rms.split('\n')

    imports = []

    for line in rms:
        # This only works for 1 include per line, without indentation.
        matches = re.findall('^include "(.*?)";', line, re.S)

        for match in matches:
            imports.append(os.path.join(deps_path, match))

    import_rms = []

    for import_file in imports:
        import_rms += get_dependencies(import_file, deps_path)
        imports = import_rms + imports

    return imports


def merge(includes, out_path):
    os.makedirs(os.path.dirname(out_path), exist_ok=True)

    with open(out_path, 'w') as file:
        for src_path in includes:
            with open(src_path, 'r') as src:
                for line in src.readlines():
                    if line.startswith('include'):
                        file.write('// ' + line)
                    else:
                        file.write(line)

            file.write('\n')


def run_compile():
    tasks = []

    # Preprocess filename.
    if os.path.isdir(args.src_path):
        for file in [f for f in os.listdir(args.src_path) if f.endswith('.xs')]:
            tasks.append(file)

        src_dir = args.src_path
    else:
        tasks.append(os.path.basename(args.src_path))
        src_dir = os.path.dirname(args.src_path)

    for task in tasks:
        # Get full path of the original source file.
        src_path = os.path.join(src_dir, task)

        # Get list of dependencies in reverse order.
        includes = get_dependencies(src_path, args.deps_path)

        # Append self to dependencies.
        includes.append(src_path)

        # Compile all required files.
        merge(includes, os.path.join(args.out_path, task))


run_compile()
