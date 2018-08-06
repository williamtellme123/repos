#!/usr/bin/python3
from pyxlsb import open_workbook
import csv
import re
import string
import argparse

# Written: 8/2/18
# Billy Rogers
#
# Converts XLSB file to csv file
#   8/3/18 Added error handling, call parameters
# python3 xlsb2csv.py old_file.xlbs new_file.csv

def main(xlsb_file, csv_file):

    regex = re.compile('[%s]' % re.escape(string.punctuation))
    print("starting with")
    with open(csv_file, 'w') as csv_file:                            # open new(empty) csv
        writer = csv.writer(csv_file)
        with open_workbook(xlsb_file) as wb:                         # open xlsb
            with wb.get_sheet(1) as sheet:
                for row in sheet.rows():
                    values = [regex.sub(' ', str(r.v)) for r in row] # remove puntuation
                    csv_line = ','.join(str(n) for n in values)      # combine values
                    csv_line = csv_line.split(',')                   # convert to list
                    writer.writerow(csv_line)                        # write to csv
    print("bye")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Converts xlsb file to csv")
    parser.add_argument("xlsb", type=str, help="provide the xlsb_filename.xlsb")
    parser.add_argument("--csv", default="local.csv", type=str, help="provide the csv_filename.csv")
    args = vars(parser.parse_args())
    main(xlsb_file=args["xlsb"], csv_file=args["csv"])

