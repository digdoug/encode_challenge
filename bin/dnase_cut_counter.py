#!/apps/python/2.7.11/gcc-5.3.0/bin/python2.7

# Copyright (C) 2016 Jason Piper - j.piper@me.com
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import argparse
import pyDNase
from clint.textui import progress, puts

parser = argparse.ArgumentParser(description='Annotates a BED file with with the number of DNase cuts in it')
parser.add_argument("-A",action="store_true", help="ATAC-seq mode (default: False)",default=False)
parser.add_argument("regions", help="BED file")
parser.add_argument("reads", help="The BAM file containing the DNase-seq data")
parser.add_argument("output", help="filename to write the output to")
args  = parser.parse_args()

reads  = pyDNase.BAMHandler(args.reads, caching=0, ATAC=args.A)
regions = pyDNase.GenomicIntervalSet(args.regions)
ofile = open(args.output,"w")

puts("Writing output...")
for i in progress.bar(regions):
    i.score   = sum([sum(j) for j in reads[i].values()])
    print >> ofile, i
