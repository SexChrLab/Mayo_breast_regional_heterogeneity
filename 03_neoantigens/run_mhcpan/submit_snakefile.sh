#!/bin/bash
#SBATCH --job-name=neoantigens  # Job name
#SBATCH --mail-type=END,FAIL           # notifications for job done & fail
#SBATCH --mail-user=tphung3@asu.edu # send-to address
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH -t 30:00:00

snakemake --snakefile run_mhcpan.snakefile -j 43 --cluster "sbatch --mem=12000 -c 4 -t 24:00:00" --rerun-incomplete
