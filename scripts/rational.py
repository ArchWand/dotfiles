#!/usr/bin/env python3
import sys

if len(sys.argv) == 1:
    print("Usage: ./rational <decimal> [max_denominator]")
    sys.exit(1)

decimal = float(sys.argv[1])
max_denominator = int(sys.argv[2]) if len(sys.argv) > 2 else 1000

def approximate(decimal, max_denominator):
    min_error = 1
    result = (0, 1)
    for denominator in range(1, max_denominator + 1):
        numerator = round(decimal * denominator)
        error = abs(numerator / denominator - decimal)
        if error < min_error:
            min_error = error
            result = (numerator, denominator)
    return result

numerator, denominator = approximate(decimal, max_denominator)
print(f"{numerator}/{denominator}")
