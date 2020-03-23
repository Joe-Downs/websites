import argparse
import csv
parser = argparse.ArgumentParser()
parser.add_argument("srcFolder", help="Location of CSV file(s) to be updated")
parser.add_argument("dstFolder", help="Location of updated CSV file(s)")
parser.add_argument("-v", "--verbosity", action="count", default=0, 
                    help="Increases output verbosity")
args = parser.parse_args()
src_folder = args.srcFolder
dst_folder = args.dstFolder

round1 = []

with open(filepath, newline="") as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        round1.append(
        
