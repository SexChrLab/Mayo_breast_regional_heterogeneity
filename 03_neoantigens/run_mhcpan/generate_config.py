# Generate the config file for running run_mhcpan.snakefile
import json

data = {}
data["samples"] = {}

hla_lists = set()
with open("/home/tphung3/softwares/netMHCstabpan-1.0/data/MHC_pseudo.dat", "r") as f:
    for line in f:
        col = line.rstrip("\n").split()
        hla_lists.add(col[0])

with open("/scratch/tphung3/Mayo_breast_regional_heterogeneity/00_config/MAYO_breastcancer_config.json") as json_file:
    samples = json.load(json_file)
    for i in samples["tumor_names"]:
        for item in samples[i]:
            if item == "normal":
                normal_name = samples[i]["normal"]
                # print(normal_name)
                data["samples"][i] = []
                with open("/scratch/tphung3/Mayo_breast_regional_heterogeneity/02_hla/" + normal_name + "/hla/R1_bestguess_G.txt", "r") as f:
                    for line in f:
                        if line.startswith("A") or line.startswith("B") or line.startswith("C"):
                            hla = line.rstrip("\n").split("\t")[2]
                            type = hla.split("*")[0]
                            alleles = hla.split("*")[1].split(":")
                            format_hla = "HLA-" + type + alleles[0] + ":" + alleles[1]
                            if format_hla in hla_lists:
                                data["samples"][i].append(format_hla)

with open("run_mhcpan_config.json", "w") as outfile:
    json.dump(data, outfile)