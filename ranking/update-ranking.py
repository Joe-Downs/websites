import argparse
parser = argparse.ArgumentParser()
parser.add_argument("filepath", help="Location of CSV file to be updated")
parser.add_argument("-v", "--verbosity", action="count", default=0, 
                    help="Increases output verbosity")
args = parser.parse_args()
filepath = args.filepath
