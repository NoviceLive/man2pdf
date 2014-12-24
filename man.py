#!/usr/bin/env python3

import os

unistd = '/usr/include/asm/'
man2 = '/home/colosseum/Documents/man-pages-3.75/man2'

def extract(raw):
    return raw.replace('#define __NR_', '').strip().split(' ')[0]

def lines(filename):
    return sum(1 for line in open(filename))

sys_64 = ['_exit' if extract(line) == 'exit' else extract(line) for line in open(os.path.join(unistd, 'unistd_64.h')) if '#define' in line and '_UNISTD_' not in line]
sys_32 = ['_exit' if extract(line) == 'exit' else extract(line) for line in open(os.path.join(unistd, 'unistd_32.h')) if '#define' in line and '_UNISTD_' not in line]

na_64 = [i for i in sys_64 if not os.path.isfile(os.path.join(man2, i) + '.2')]
na_32 = [i for i in sys_32 if not os.path.isfile(os.path.join(man2, i) + '.2')]

dup = [i.replace('.2', '') for i in os.listdir(man2) if lines(os.path.join(man2, i)) == 1 and 'man2' in open(os.path.join(man2, i)).read()]

[open(os.path.join(man2, '64.2'), 'a').write(open(os.path.join(man2, i) + '.2').read().split('.SH COLOPHON')[0]) for i in sys_64 if i not in na_64 and i not in dup]
[open(os.path.join(man2, '32.2'), 'a').write(open(os.path.join(man2, i) + '.2').read().split('.SH COLOPHON')[0]) for i in sys_32 if i not in na_32 and i not in dup]

#[colosseum@novicelive man-pages-3.75]$ pdfroff -man --no-toc-relocation man2/32.2 --pdf-output=32.pdf
#[colosseum@novicelive man-pages-3.75]$ pdfroff -man --no-toc-relocation man2/64.2 --pdf-output=64.pdf
