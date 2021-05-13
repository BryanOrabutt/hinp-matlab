#!/usr/bin/env python3

import os

in_dir = "/home/borabutt/matlab/hinp/agnd_test/csv"
#neg_fn = "../csv2"
out_dir = "/home/borabutt/matlab/hinp/agnd_test/csv_parsed/"


for fn in os.listdir(in_dir):
    with open(os.path.join(in_dir, fn), 'r') as f:
        ofile =  os.path.join(out_dir, fn[:-4] + "_parsed.csv")
        ofile_fh = open(ofile, 'w')
        print("In file: %s" % (os.path.join(in_dir, fn)))
        first_line = True
        for line in f:
            if first_line:
                first_line = False
                continue
            tokens = line.split('\t')
            tvc = int(tokens[0].strip(), 16) >> 2
            lg = int(tokens[1].strip(), 16) >> 2
            hg = int(tokens[2].strip(), 16) >> 2
            
            ofile_fh.write("%d,%d,%d\n" % (tvc, lg, hg))
        
        ofile_fh.close()
