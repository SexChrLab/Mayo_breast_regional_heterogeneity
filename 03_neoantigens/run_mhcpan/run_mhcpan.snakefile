configfile: "run_mhcpan_config.json"

rule all:
    input:
        [f"{key}/{value}/9_mers/netmhc.xsl" for key, values in config["samples"].items() for value in values]

rule netmhcpan:
    input:
        "../generate_peptides/{key_sample}_peptides_rmWT.txt"
    output:
        "{key_sample}/{value_hla}/9_mers/netmhc.xsl"
    params:
        "{value_hla}"
    shell:
        """
        /home/tphung3/softwares/netMHCpan-4.0/netMHCpan -a {params} -f {input} -BA -s -xls -l 9  -xlsfile {output}
        """
