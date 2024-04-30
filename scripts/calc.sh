#!/bin/bash

python3 -qic "$(cat <<EOF
from math import *
from statistics import *

EOF
)"
