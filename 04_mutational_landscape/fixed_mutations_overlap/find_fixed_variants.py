import argparse

parser = argparse.ArgumentParser(description="Return only variants that are fixed (1/1.")
parser.add_argument("--input_vcf",required=True,help="Input the path to the vcf file. For example: "
                                                     "/scratch/tphung3/Mayo_breast_regional_heterogeneity/"
                                                     "01_neoepitope/intermediate_files/PS13-1750-A1-P4.VarScan_vep.vcf")
parser.add_argument("--output_vcf",required=True,help="Input the path to the output file")

args = parser.parse_args()

outfile = open(args.output_vcf, "w")
with open(args.input_vcf, "r") as f:
    for line in f:
        if line.startswith("#"):
            print(line.rstrip("\n"), file=outfile)
        else:
            items = line.rstrip("\n").split("\t")
            if items[10].startswith("1/1"):
                print(line.rstrip("\n"), file=outfile)