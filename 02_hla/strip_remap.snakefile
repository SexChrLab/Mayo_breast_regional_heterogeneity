import os

# Strip reads from Tim's bam files and remp to 1000G version of GRCh38 for HLA typing

configfile: "strip_remap_config.json"

rule all:
    input: #remap to 1000G version of GRCh38
        expand("remap_GRCh38_bams/{sample}.GRCh38.full.analysis.set.plus.decoy.hla.mkdup.sorted.bam", sample=config["sample_names"])
    input: #strip reads from orginal GTEx bam
        expand("strip_reads/{sample}/{sample}_xyalign.log", sample=config["sample_names"])

rule strip_reads:
    input:
        BAM = os.path.join(config["bams_directory"], "{sample}.hg38.sorted.mkdup.recal.indelrealigned.bam")
    output:
        LOG = "strip_reads/{sample}/{sample}_xyalign.log"
    conda:
        "/scratch/tphung3/Cayo_x_inactivation/envs/xyalign.yml"
    params:
        DIR = "strip_reads/{sample}",
        SAMPLE_ID = "{sample}",
        cpus="4",
        xmx="4g",
        compression="3"
    shell:
        "xyalign --STRIP_READS --ref null --bam {input.BAM} --cpus {params.cpus} --xmx {params.xmx} --sample_id {params.SAMPLE_ID} --output_dir {params.DIR} --chromosomes ALL"

# 1000G version of GRCh38
rule map_and_process_stripped_reads:
    input:
        fq_1 = "strip_reads/{sample}/fastq/{sample}_{sample}_1.fastq.gz",
        fq_2 = "strip_reads/{sample}/fastq/{sample}_{sample}_2.fastq.gz",
        fai = "/data/CEM/shared/public_data/references/1000genomes_GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai",
        ref = "/data/CEM/shared/public_data/references/1000genomes_GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa"
    output:
        "remap_GRCh38_bams/{sample}.GRCh38.full.analysis.set.plus.decoy.hla.mkdup.sorted.bam"
    params:
        id = lambda wildcards: config[wildcards.sample]["ID"],
        sm = lambda wildcards: config[wildcards.sample]["SM"],
        lb = lambda wildcards: config[wildcards.sample]["LB"],
        pu = lambda wildcards: config[wildcards.sample]["PU"],
        pl = lambda wildcards: config[wildcards.sample]["PL"]
    threads:
        4
    shell:
        "bwa mem -t {threads} -R "
        "'@RG\\tID:{params.id}\\tSM:{params.sm}\\tLB:{params.lb}\\tPU:{params.pu}\\tPL:{params.pl}' "
        "{input.ref} {input.fq_1} {input.fq_2} "
        "| samblaster "
        "| samtools fixmate -O bam - - | samtools sort "
        "-O bam -o {output}"
