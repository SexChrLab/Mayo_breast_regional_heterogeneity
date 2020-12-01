import os

configfile: "../00_config/MAYO_breastcancer_config.json"

# Path to packages not in conda
VarScan_path = "external_scripts/VarScan.v2.3.9.jar"
bamreadcount_path = "external_scripts/bam-readcount"
perl_filter_path = "external_scripts/fpfilter-2.pl"
vep_path = "external_scripts/ensembl-tools-release-86/scripts/variant_effect_predictor/variant_effect_predictor.pl"
plugin_path = "/home/tphung3/.vep/Plugins"
perl5lib_path = "/home/tphung3/softwares/miniconda3/envs/epitopepipeline/lib/site_perl/5.26.2/"

rule all:
    input: #generate peptides
        expand("peptides/{sample}.VarScan_vep.15.peptide", sample=config["tumor_names"]),
        expand("peptides/{sample}.VarScan_vep.17.peptide", sample=config["tumor_names"]),
        expand("peptides/{sample}.VarScan_vep.19.peptide", sample=config["tumor_names"]),
        expand("peptides/{sample}.VarScan_vep.21.peptide", sample=config["tumor_names"])
    input: #varscan
        expand("intermediate_files/{sample}.VarScan.snp.Somatic.hc.filter", sample=config["tumor_names"])
    input:
        expand("bams/{sample}.hg38.sorted.mkdup.recal.indelrealigned.bam", sample = config["sample_names"]),
        expand("bams/{sample}.hg38.sorted.mkdup.recal.indelrealigned.bai", sample = config["sample_names"]),
        expand("pileups/{sample}.pileup", sample = config["sample_names"])


rule mk_symlink_for_bam:
    input:
        os.path.join(config["original_bams_directory"], "{sample}.hg38.sorted.mkdup.recal.indelrealigned.bam")
    output:
        "bams/{sample}.hg38.sorted.mkdup.recal.indelrealigned.bam"
    shell:
        """
        ln -s {input} {output}
        """

rule mk_symlink_for_bai:
    input:
        os.path.join(config["original_bams_directory"], "{sample}.hg38.sorted.mkdup.recal.indelrealigned.bai")
    output:
        "bams/{sample}.hg38.sorted.mkdup.recal.indelrealigned.bai"
    shell:
        """
        ln -s {input} {output}
        """

rule bam_pileup: #for both normal and tumor
    input:
        fa = config["reference"],
        bam = "bams/{sample}.hg38.sorted.mkdup.recal.indelrealigned.bam"
    output:
        pileup = "pileups/{sample}.pileup"
    threads: 4
    shell:
        """
        samtools mpileup -f {input.fa} {input.bam} > {output.pileup}
        """

rule run_VarScan:
    input:
        normal_pileup = lambda wildcards: os.path.join(
			"pileups/", config[wildcards.sample]["normal"] +  ".pileup"),
        tumor_pileup = lambda wildcards: os.path.join(
			"pileups/", config[wildcards.sample]["tumor"] + ".pileup")
    output:
        snp = "somatic_mutation/{sample}/{sample}.VarScan.snp",
        indel = "somatic_mutation/{sample}/{sample}.VarScan.indel"
    params:
        VarScan = VarScan_path,
        basename = "somatic_mutation/{sample}/{sample}.VarScan"
    threads: 4
    shell:
        "java -jar {params.VarScan} somatic {input.normal_pileup} {input.tumor_pileup} {params.basename} –min-coverage 10 –min-var-freq 0.08 –somatic-p-value 0.05"

rule isolate_calls_by_type_and_confidence:
    input:
        VarScan_snp = "somatic_mutation/{sample}/{sample}.VarScan.snp"
    output:
        VarScan_snp = "somatic_mutation/{sample}/{sample}.VarScan.snp.Somatic.hc"
    params:
        VarScan = VarScan_path
    shell:
        """
        java -jar {params.VarScan} processSomatic {input.VarScan_snp}
        """

rule somatic_filter:
    input:
        snp_somatic_hc = "somatic_mutation/{sample}/{sample}.VarScan.snp.Somatic.hc",
        indel = "somatic_mutation/{sample}/{sample}.VarScan.indel"
    output:
        snp_somatic_hc_filter = "somatic_mutation/{sample}/{sample}.VarScan.snp.Somatic.hc.filter"
    params:
        VarScan = VarScan_path
    shell:
        """
        java -jar {params.VarScan} somaticFilter {input.snp_somatic_hc} -indel-file {input.indel} -output-file {output.snp_somatic_hc_filter}
        """

rule convert_to_bed_fmt:
    input:
        snp_somatic_hc_filter = "somatic_mutation/{sample}/{sample}.VarScan.snp.Somatic.hc.filter"
    output:
        snp_somatic_hc_filter_bed = "somatic_mutation/{sample}/{sample}.VarScan.snp.Somatic.hc.filter.bed"
    shell:
        """
        awk -F "\t" '{{print $1 "\t" $2 "\t" $2 }}' {input.snp_somatic_hc_filter} | tail -n+2 > {output.snp_somatic_hc_filter_bed}
        """

rule readcount:
    input:
        fa = config["reference"],
        snp_somatic_hc_filter_bed = "somatic_mutation/{sample}/{sample}.VarScan.snp.Somatic.hc.filter.bed",
        tumor_bam = lambda wildcards: os.path.join(
			config["original_bams_directory"], config[wildcards.sample]["tumor"] + ".hg38.sorted.mkdup.recal.indelrealigned.bam") #this is for tumor bams
    output:
        readcounts = "somatic_mutation/{sample}/{sample}.readcounts"
    params:
        bamreadcount = bamreadcount_path
    shell:
        """
        {params.bamreadcount} -q 1 -b 20 -f {input.fa} -l {input.snp_somatic_hc_filter_bed} {input.tumor_bam} > {output.readcounts}
        """

rule perl_filter:
    input:
        snp_somatic_hc_filter = "somatic_mutation/{sample}/{sample}.VarScan.snp.Somatic.hc.filter",
        readcounts = "somatic_mutation/{sample}/{sample}.readcounts"
    output:
        out = "somatic_mutation/{sample}/{sample}.VarScan_variants_filter.pass"
    params:
        basename = "somatic_mutation/{sample}/{sample}.VarScan_variants_filter",
        perlfilter = perl_filter_path
    shell:
        """
        perl {params.perlfilter} {input.snp_somatic_hc_filter} {input.readcounts} --output-basename {params.basename}
        """

rule convert_to_vcf:
    input:
        "somatic_mutation/{sample}/{sample}.VarScan_variants_filter.pass"
    output:
        "somatic_mutation/{sample}/{sample}.VarScan_variants_filter.pass.vcf"
    shell:
        """
        python external_scripts/VarScan2_format_converter.py {input} > {output}
        """

rule rm_header_from_vcf:
    input:
        "somatic_mutation/{sample}/{sample}.VarScan_variants_filter.pass.vcf"
    output:
        "somatic_mutation/{sample}/{sample}.VarScan_variants_filter.pass.noheader.vcf"
    shell:
        """
        egrep -v "^#" {input} > {output}
        """

rule run_vep:
    input:
        "somatic_mutation/{sample}/{sample}.VarScan_variants_filter.pass.noheader.vcf"
    output:
        "somatic_mutation/{sample}/{sample}.VarScan_vep.vcf"
    params:
        vep = vep_path,
        plugins = plugin_path,
        perl5lib = perl5lib_path
    shell:
        """
        PERL5LIB={params.perl5lib} perl {params.vep} -i {input} --format vcf --cache --assembly GRCh38 --offline --vcf -o {output}  --force_overwrite --plugin Wildtype --dir_plugins {params.plugins} --symbol --terms SO --plugin Downstream
        """
