import sys

with open(sys.argv[1]) as f:
	next(f)
	line1 = next(f).strip().split()
	line2 = next(f).strip().split()

line1 = line1[2:202]
line2 = line2[2:202]

z = zip(line1[50:], line2[:-50])
print z
