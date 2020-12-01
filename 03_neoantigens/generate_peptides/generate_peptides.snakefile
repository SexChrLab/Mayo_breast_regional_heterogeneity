configfile: "../../00_config/MAYO_breastcancer_config.json"

rule all:
    input:
        expand("{sample}_peptides.txt", sample=config["tumor_names"])

rule generate_peptides:
    input:
        "../../01_somatic_mutation_calling/somatic_mutation/{sample}/{sample}.VarScan_vep.vcf"
    output:
        "{sample}_peptides.txt"
    params:
        len = 21
    shell:
        """
        pvacseq generate_protein_fasta {input} {params.len} {output}
        """
