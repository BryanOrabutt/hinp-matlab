#!/usr/bin/env python3

import os

in_dir = "C:/Users/frien/Documents/research/matlab/hinp/py/si_data"
#neg_fn = "../csv2"
out_dir = "C:/Users/frien/Documents/research/matlab/hinp/py/output/"

#ofile_pos = open("../csv/hg_pos_parsed.csv", 'w')
#ofile_neg = open("../csv/hg_neg_parsed.csv", 'w')
channels = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']

for fn in os.listdir(in_dir):
    with open(os.path.join(in_dir, fn), 'r') as f:
        ofile_hg_fn = os.path.join(out_dir, fn[:-4] + "_hg_parsed.csv")
        ofile_lg_fn = os.path.join(out_dir, fn[:-4] + "_lg_parsed.csv")
        ofile_tvc_fn = os.path.join(out_dir, fn[:-4] + "_tvc_parsed.csv")
        ofile_hit_fn = os.path.join(out_dir, fn[:-4] + "_hit_parsed.csv")
        print("In file: %s" % (os.path.join(in_dir, fn)))
        ofile_hg = open(ofile_hg_fn, 'w')
        ofile_lg = open(ofile_lg_fn, 'w')
        ofile_tvc = open(ofile_tvc_fn, 'w')
        ofile_hit = open(ofile_hit_fn, 'w')
        for line in f:
            tokens = line.split('\t')
            if line[0] in channels:
                
                hit = int(tokens[4])
                ofile_hit.write("%d" % (hit))
                
                hg_val = int(tokens[3].strip(), 16)
                hg_val = (hg_val & 0xffff) >> 2
                ofile_hg.write("%d" % (hg_val))
                
                lg_val = int(tokens[2].strip(), 16)
                lg_val = (lg_val & 0xffff) >> 2
                ofile_lg.write("%d" % (lg_val))
                
                tvc_val = int(tokens[1].strip(), 16)
                tvc_val = (tvc_val & 0xffff) >> 2
                ofile_tvc.write("%d" % (tvc_val))
                
                if(tokens[0] == '15'):
                    ofile_hg.write("\n")
                    ofile_lg.write("\n")
                    ofile_tvc.write("\n")
                    ofile_hit.write("\n")
                else:
                    ofile_hg.write(",")
                    ofile_lg.write(",")
                    ofile_tvc.write(",")
                    ofile_hit.write(",")
                
        ofile_hg.close()
        ofile_lg.close()
        ofile_tvc.close()
'''
with open(neg_fn, 'r') as f:
    for line in f:
        tokens = line.split('\t')
        if line[0] in channels:
            val = int(tokens[-1].strip(), 16)
            val = val & 0xffff
            ofile_neg.write("%d" % (val))
            
            if(tokens[0] == '15'):
                ofile_neg.write("\n")
            else:
                ofile_neg.write(",")
        
ofile_neg.close()
'''
