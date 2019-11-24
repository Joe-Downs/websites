import argparse

parser = argparse.ArgumentParser()
parser.add_argument("output", help = "Prints out input")
args = parser.parse_args()
print(args.output)
