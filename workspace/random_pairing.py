#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct  7 13:58:26 2025

@author: matthew
"""

import sys
import os
import random


# %% Read input file

if len(sys.argv) <= 1:
    print(
        'Invalid arguments, please include a file name for the generator.\n\n'
        'The file can be a vertical list of first names, or a vertical list '
        'of names in the form\n'
        '<Last Name>, <First Name>\n\n'
        'For example:\n'
        'carl\n'
        'katia\n'
        'lucia\n\n'
        'or\n\n'
        'warburton, carl\n'
        'grim, katia\n'
        'mar, lucia\n'
        '\n'
        'Usage: $ random_pairing.py <filename>'
    )
    sys.exit()
if os.path.exists(sys.argv[1]):
    with open(sys.argv[1]) as file:
        raw_lines = file.readlines()
        name_lines = [line for line in raw_lines if line.strip()]
else:
    print('File not found, exiting...')
    sys.exit()


# %% Parse input file
names = []

"""
print('Are the names in <Last name>, <First name> format? (y/N)')
try:
    format_q = input('> ').lower()
except KeyboardInterrupt:
    print('Exiting...')
    sys.exit()
"""

if ',' in name_lines[0]:
    for line in name_lines:
        first_name = line.split(',')[1].strip()
        last_name = line.split(',')[0].strip()
        names.append(f'{first_name} {last_name}')
else:
    for line in name_lines:
        names.append(line.strip())

random.shuffle(names)


# %% Generate and print the pairs

pairs = []

# Set up a trio if there are an odd number of students
if len(names) % 2 == 1:
    tmp = (
        names.pop().title(),
        names.pop().title(),
        names.pop().title()
    )
    pairs.append(tmp)

# Pair up the students and add them to the list of pairs
while names:
    tmp = (names.pop().title(), names.pop().title())
    pairs.append(tmp)

# Make a list that looks nicer to output
output_list = []
tmp_string = ''
for pair in pairs:
    output_list.append(' and '.join(pair))

# Make one big string to print and potentially save to a file
output_string = '\n'.join(output_list)
print('\n\n' + output_string + '\n\n')


# %% Ask to save the file

print('Would you like to save the list to a file? (y/N)')
try:
    save_file = input('> ').lower()
except KeyboardInterrupt:
    print('Exiting...')
    sys.exit()
if save_file in ('y', 'yes'):
    print('Enter a file name for the list.'
          ' Ex. student_pairs')
    try:
        file_name = input('> ') + '.txt'
    except KeyboardInterrupt:
        print('Exiting...')
        sys.exit()

    if os.path.exists(file_name):
        overwrite = input('File already exists, overwrite? (y/N)\n> ').lower()
        if overwrite in ('y', 'yes'):
            print(f'Overwriting list to {file_name}...')
            with open(file_name, 'w') as f:
                f.write(output_string)
        else:
            print('File not written, exiting...')
            sys.exit()
    else:
        print(f'Writing list to {file_name}...')
        with open(file_name, 'w') as f:
            f.write(output_string)
    print('Exiting...')
else:
    print('File not written, exiting...')
    sys.exit()
