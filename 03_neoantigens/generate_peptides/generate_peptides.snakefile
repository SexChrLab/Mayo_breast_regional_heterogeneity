configfile: "../../00_config/MAYO_breastcancer_config.json"

rule all:
    input:
        expand("{sample}_peptides.txt", sample=config["tumor_names"]),
        expand("{sample}_peptides_rmWT.txt", sample=config["tumor_names"])

rule generate_peptides:
    input:
        "../../01_somatic_mutation_calling/somatic_mutation/{sample}/{sample}.VarScan_vep.vcf"
    output:
        "{sample}_peptides.txt"
    params:
        len = 17
    shell:
        """
        pvacseq generate_protein_fasta {input} {params.len} {output}
        """

rule remove_wildtypes:
    input:
        "{sample}_peptides.txt"
    output:
        "{sample}_peptides_rmWT.txt"
    params:
        len = 17
    shell:
        """
        cat {input} | grep -A 1 ">MT" | sed '/--/d' > {output}
        """
