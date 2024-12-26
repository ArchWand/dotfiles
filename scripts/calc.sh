#!/bin/bash

python3 -qic "$(cat <<EOF
from math import *
from random import *
from statistics import *
import sys

sys.set_int_max_str_digits(10000)

def rationalize(decimal, max_denom=1000, max_error=0.00000001):
	ipart, decimal = divmod(decimal, 1)
	nl, dl, nr, dr, nm, dm = 0, 1, 1, 1, round(decimal), 1
	while dl + dr <= max_denom and abs(nm / dm - decimal) > max_error:
		nm, dm = nl + nr, dl + dr
		if nm / dm < decimal:  nl, dl = nm, dm
		else:                  nr, dr = nm, dm
	return int(ipart * dm + nm), dm

def prime_factor(n):
    facts = []
    for f in range(2, int(sqrt(n))+1):
        if n % f == 0:
            i = 0
            while n % f == 0:
                n, i = n // f, i+1
            facts.append((f, i))
    return facts

EOF
)"

