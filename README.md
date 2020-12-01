# Mayo_breast_regional_heterogeneity
Multiregional sampling analysis

## 01_somatic_mutation_calling
- Use Varscan to genotype somatic mutations
- Snakefile: `MAYO_breastcancer.Snakefile`

## 02_Hla
- HLA typing using `HLA-LA` (https://github.com/DiltheyLab/HLA-LA)
- Because `HLA-LA` requires the reads to be mapped to the 1000 Genome version of GRCh38, the first step is to strip the reads from the BAM files using `XYalign` and map the reads to the 1000 Genome version of GRCh38.
  - Snakefile: `strip_rempa.snakefile`
  - Config file: `strip_remap_config.json`
- Run `HLA-LA`:
  - Snakefile: `hla.snakefile`
  - Config file: `hla_config.json`
- After HLA typing, rename the hla directory by running the Python script `rename_hla_directory.py`

## 03_neoantigens
### generate_peptides:
- Use the program `pvacseq` to generate peptides (21 mers)
- Snakefile: `generate_peptides.snakefile`

### run_mhcpan
- Use the Python script `generate_config.py` to generate the config file `run_mhcpan_config.json`
- Snakefile: `run_mhcpan.snakefile`

### filter_peptides
- Use the Python script `generate_hla_list.py` to generate a list of hla for each sample
- Use the Bash script `filter_peptides.sh` for filtering peptides

## 04_mutational_landscape
1. Plot the number of somatic mutations per sample:
- Use the Rscript `plot_num_variants_per_individual.R` (under `04_mutational_landscape/tabulate_num_variants`)
2. Plot upset plot for all of the somatic mutations
- Scripts are under `all_mutations_overlap`
- Use the Python script `make_database_for_upsetr`
- Use the Rscript `plot_upset.R`
3. Plot upset plot for fixed mutations
- Scripts are under `fixed_mutations_overlap`
- Use Python script `find_fixed_variants.py` (Snakefile `fixed_variants_analysis.snakefile`) to find fixed variants. 
- Use Python script `make_database_for_upsetr_fixed_variants.py` for generating the data for upset plot
- Use the Rscript `plot_upset_fixed_mutations.R` for plotting. 

