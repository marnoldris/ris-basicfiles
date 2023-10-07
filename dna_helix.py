#!/usr/bin/env python3
# -*- coding: utf-8 -*-



import random
import sys
import os
import time

PAUSE = 0.10
WIDTH = os.get_terminal_size()[0]
PADDING = (WIDTH // 2) - 9

ROWS = [
                      #1234567890
        ' '*PADDING + '         ##',
        ' '*PADDING + '        #{}-{}#',
        ' '*PADDING + '       #{}---{}#',
        ' '*PADDING + '      #{}-----{}#',
        ' '*PADDING + '     #{}------{}#',
        ' '*PADDING + '    #{}------{}#',
        ' '*PADDING + '    #{}-----{}#',
        ' '*PADDING + '     #{}---{}#',
        ' '*PADDING + '     #{}-{}#',
        ' '*PADDING + '     ##',
        ' '*PADDING + '    #{}-{}#',
        ' '*PADDING + '    #{}---{}#',
        ' '*PADDING + '   #{}-----{}#',
        ' '*PADDING + '   #{}------{}#',
        ' '*PADDING + '    #{}------{}#',
        ' '*PADDING + '     #{}-----{}#',
        ' '*PADDING + '      #{}---{}#',
        ' '*PADDING + '       #{}-{}#'
                      #1234567890
        ]

try:
    print('DNA Animation')
    print('Press CTRL+C to quit...')
    time.sleep(0.5)
    row_index = 0
    
    while True:
        row_index += 1
        if row_index == len(ROWS):
            row_index = 0
        
        if row_index == 0 or row_index == 9:
            print(ROWS[row_index])
            continue
        random_selection = random.randint(1,4)
        if random_selection == 1:
            left_nucleotide, right_nucleotide = 'A', 'T'
        elif random_selection == 2:
            left_nucleotide, right_nucleotide = 'T', 'A'
        elif random_selection == 3:
            left_nucleotide, right_nucleotide = 'C', 'G'
        elif random_selection == 4:
            left_nucleotide, right_nucleotide = 'G', 'C'
        
        print(ROWS[row_index].format(left_nucleotide, right_nucleotide))
        time.sleep(PAUSE)
except KeyboardInterrupt:
    sys.exit()
