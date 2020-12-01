import os

configfile: "/scratch/tphung3/Mayo_breast_regional_heterogeneity/00_config/MAYO_breastcancer_config.json"

rule all:
    input:
        expand("/scratch/tphung3/Mayo_breast_regional_heterogeneity/01_neoepitope/intermediate_files/{sample}.VarScan_vep_fixed_variants.vcf", sample=config["tumor_names"]),
        expand("/scratch/tphung3/Mayo_breast_regional_heterogeneity/01_neoepitope/intermediate_files/count_num_variants/all_variants/{sample}.VarScan_vep_num_variants.txt", sample=config["tumor_names"]),
        expand("/scratch/tphung3/Mayo_breast_regional_heterogeneity/01_neoepitope/intermediate_files/count_num_variants/fixed_variants/{sample}.VarScan_vep_fixed_variants_num_variants.txt", sample=config["tumor_names"])

rule find_fixed_variants:
    input:
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/01_somatic_mutation_calling/somatic_mutation/{sample}/{sample}.VarScan_vep.vcf"
    output:
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/01_somatic_mutation_calling/somatic_mutation/{sample}/{sample}.VarScan_vep_fixed_variants.vcf"
    shell:
        """
        python /scratch/tphung3/Mayo_breast_regional_heterogeneity/04_mutational_landscape/fixed_mutations_overlap/find_fixed_variants.py --input_vcf {input} --output_vcf {output}
        """

rule count_num_all_variants:
    input:
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/01_somatic_mutation_calling/somatic_mutation/{sample}/{sample}.VarScan_vep.vcf"
    output:
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/04_mutational_landscape/fixed_mutations_overlap/count_num_variants/all_variants/{sample}.VarScan_vep_num_variants.txt"
    params:
        id = "{sample}"
    shell:
        """
        python /home/tphung3/softwares/tanya_repos/vcfhelper/calc_num_site_in_vcf.py --vcf {input} --id {params.id} > {output}
        """

rule count_num_fixed_variants:
    input:
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/01_somatic_mutation_calling/somatic_mutation/{sample}/{sample}.VarScan_vep_fixed_variants.vcf"
    output:
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/04_mutational_landscape/fixed_mutations_overlap/count_num_variants/fixed_variants/{sample}.VarScan_vep_fixed_variants_num_variants.txt"
    params:
        id = "{sample}"
    shell:
        """
        python /home/tphung3/softwares/tanya_repos/vcfhelper/calc_num_site_in_vcf.py --vcf {input} --id {params.id} > {output}
        """
