#!/usr/bin/env python3
import argparse

def rationalize(decimal, max_denom=1000, max_error=0):
    # Split the decimal so that we operate on a number between 0 and 1
    ipart, decimal = divmod(decimal, 1)

    # F_1
    nl, dl = 0, 1
    nr, dr = 1, 1
    # forward declartions
    nm, dm = round(decimal), 1

    while dl + dr <= max_denom and abs(nm / dm - decimal) > max_error:
        # Find the mediant
        nm, dm = nl + nr, dl + dr

        # Update the bounds
        if nm / dm < decimal:  nl, dl = nm, dm
        else:                  nr, dr = nm, dm

    return int(ipart * dm + nm), dm

def main():
    parser = argparse.ArgumentParser(description="Convert a decimal to a rational number.")
    parser.add_argument("decimal", type=float, help="The decimal number to convert.")
    parser.add_argument("-m", "--max_denominator", type=int, default=1000,
                      help="Maximum allowed denominator (default: 1000).")
    parser.add_argument("-e", "--max_error", type=float, default=0.0,
                      help="Error at which to stop the search (default: 0).")

    args = parser.parse_args()
    print('{}/{}'.format(*rationalize(args.decimal, args.max_denominator, args.max_error)))

if __name__ == "__main__":
    main()
