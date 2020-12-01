import os

# conda environment: hlala
# Before running this script, do the following:
# vim ~/softwares/miniconda3/envs/hlala/opt/hla-la/src/paths.ini
# Change the working directory to /scratch/tphung3/Mayo_breast_regional_heterogeneity/02_hla/
# Replace the file name from `PS13-1750-A8-P4.GRCh38.full.analysis.set.plus.decoy.hla.mkdup.sorted.bam` to `PS13_1750_A8_P4.GRCh38.full.analysis.set.plus.decoy.hla.mkdup.sorted.bam` because HLA-LA does not like the character `-`.

configfile: "hla_config.json"

# Tool paths:
bwa_path = "bwa"
samtools_path = "samtools"

rule all:
    input:
        expand("{sample_name}/hla/R1_bestguess_G.txt", sample_name=config["sample_names"])
    input:
        expand(os.path.join(config["reprocessed_bams_directory"], "{sample_name}.GRCh38.full.analysis.set.plus.decoy.hla.mkdup.sorted.bam.bai"), sample_name=config["sample_names"])

rule index_bam:
    input:
        os.path.join(config["reprocessed_bams_directory"], "{sample_name}.GRCh38.full.analysis.set.plus.decoy.hla.mkdup.sorted.bam")
    output:
        os.path.join(config["reprocessed_bams_directory"], "{sample_name}.GRCh38.full.analysis.set.plus.decoy.hla.mkdup.sorted.bam.bai")
    shell:
        "samtools index {input}"

rule run_hlala:
    input:
        os.path.join(config["reprocessed_bams_directory"], "{sample_name}.GRCh38.full.analysis.set.plus.decoy.hla.mkdup.sorted.bam")
    output:
        "{sample_name}/hla/R1_bestguess_G.txt"
    params:
        dir = "{sample_name}"
    shell:
        "PERL5LIB=/home/tphung3/softwares/miniconda3/envs/polysolver/lib/site_perl/5.26.2/ ~/softwares/miniconda3/envs/hlala/bin/HLA-LA.pl --BAM {input} --graph PRG_MHC_GRCh38_withIMGT --sampleID {params.dir} --maxThreads 7"

# After running the run_hlala rule, run the Python script `rename_hla_directory`.
