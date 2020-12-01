#!/bin/bash
#SBATCH --job-name=MAYO_strip_map  # Job name
#SBATCH --mail-type=END,FAIL           # notifications for job done & fail
#SBATCH --mail-user=tphung3@asu.edu # send-to address
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH -t 96:00:00
#SBATCH -q tempboost

# conda activate neoepitope
# Strip reads
snakemake --snakefile strip_remap.snakefile -j 43 --use-conda --cluster-config /scratch/tphung3/Cayo_x_inactivation/cluster.json --cluster "sbatch -n {cluster.n} --nodes 1 -t 24:00:00 " --latency-wait 60

# conda activate 2019July_cayo
# map
snakemake --snakefile strip_remap.snakefile -j 43 --cluster-config /scratch/tphung3/Cayo_x_inactivation/cluster.json --cluster "sbatch -n {cluster.n} --nodes 1 -t 72:00:00 --mem=60000" --latency-wait 60
