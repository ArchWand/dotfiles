#!/bin/bash

python3 -qic "$(cat <<EOF
from math import *
from statistics import *

def rationalize(decimal, max_denom=1000, max_error=0):
	ipart, decimal = divmod(decimal, 1)
	nl, dl, nr, dr, nm, dm = 0, 1, 1, 1, round(decimal), 1
	while dl + dr <= max_denom and abs(nl+nr / dl+dr - decimal) > max_error:
		nm, dm = nl + nr, dl + dr
		nl, dl, nr, dr = (nm, dm, nr, dr) if nm / dm < decimal else (nl, dl, nm, dm)
	return int(ipart * dm + nm), dm

EOF
)"
