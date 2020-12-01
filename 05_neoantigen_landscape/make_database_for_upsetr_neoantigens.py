# In this script, we are generating database for making upset plot for neoantigens
def return_set_of_neoantigens(file_path):
    set_of_neoantigens = set()
    with open(file_path, "r") as f:
        for line in f:
            cols = line.rstrip("\n").split("\t")
            set_of_neoantigens.add(cols[0])
    return set_of_neoantigens

def main():
    # PS13-1750
    a1_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A1-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a2_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A2-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a2_p5 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A2-P5/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a3_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A3-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a4_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A4-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a5_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A5-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a6_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A6-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a7_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A7-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a8_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A8-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a9_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A9-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a10_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-1750-A10-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")

    common = a1_p4.intersection(a2_p4, a2_p5, a3_p4, a4_p4, a5_p4, a6_p4, a7_p4, a8_p4, a9_p4, a10_p4)
    print(len(common))

    all_neoantigens = a1_p4.union(a2_p4, a2_p5, a3_p4, a4_p4, a5_p4, a6_p4, a7_p4, a8_p4, a9_p4, a10_p4)

    outfile = open(
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/05_neoantigen_landscape/PS13-1750_tumors_upsetplot_input_neoantigens.csv",
        "w")
    header = ["Peptides", "A1-P4", "A2-P4", "A2-P5", "A3-P4", "A4-P4", "A5-P4", "A6-P4", "A7-P4", "A8-P4", "A9-P4",
              "A10-P4"]
    print(",".join(header), file=outfile)

    files = [a1_p4, a2_p4, a2_p5, a3_p4, a4_p4, a5_p4, a6_p4, a7_p4, a8_p4, a9_p4, a10_p4]

    for i in all_neoantigens:
        out = [i]
        for file in files:
            if i in file:
                out.append("1")
            else:
                out.append("0")
        print(",".join(out), file=outfile)

    # PS13-585
    # Primary nodes
    a1_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A1-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a2_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A2-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a3_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A3-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a3_p5 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A3-P5/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a4_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A4-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a4_p5 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A4-P5/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a5_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A5-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a6_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A6-P3-rep/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a7_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A7-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a8_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A8-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a8_p5 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A8-P5/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a9_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A9-P3-rep/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a10_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A10-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a10_p5 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A10-P5/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a10_p6 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A10-P6/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a11_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A11-P3-rep/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a11_p5 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A11-P5/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a12_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A12-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    a12_p5 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-A12-P5/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")

    common = a1_p3.intersection(a2_p3, a3_p3, a3_p5, a4_p3, a4_p5, a5_p3, a6_p3, a7_p3, a8_p3, a8_p5, a9_p3, a10_p3, a10_p5, a10_p6, a11_p3, a11_p5, a12_p3, a12_p5)
    print(len(common))

    all_neoantigens = a1_p3.union(a2_p3, a3_p3, a3_p5, a4_p3, a4_p5, a5_p3, a6_p3, a7_p3, a8_p3, a8_p5, a9_p3, a10_p3, a10_p5, a10_p6, a11_p3, a11_p5, a12_p3, a12_p5)

    outfile = open(
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/05_neoantigen_landscape/PS13-585_primary_tumors_upsetplot_input_neoantigens.csv",
        "w")
    header = ["variants", "A1-P3", "A2-P3", "A3-P3", "A3-P5", "A4-P3", "A4-P5", "A5-P3", "A6-P3", "A7-P3", "A8-P3", "A8-P5", "A9-P3", "A10-P3", "A10-P5", "A10-P6", "A11-P3", "A11-P5", "A12-P3", "A12-P5"]
    print(",".join(header), file=outfile)

    files = [a1_p3, a2_p3, a3_p3, a3_p5, a4_p3, a4_p5, a5_p3, a6_p3, a7_p3, a8_p3, a8_p5, a9_p3, a10_p3, a10_p5, a10_p6, a11_p3, a11_p5, a12_p3, a12_p5]

    for i in all_neoantigens:
        out = [i]
        for file in files:
            if i in file:
                out.append("1")
            else:
                out.append("0")
        print(",".join(out), file=outfile)


    # Distant nodes
    b1_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-B1-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    b2_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-B2-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    b3_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-B3-P3-rep/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    d1_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-D1-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    f1_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-F1-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    f2_p3 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-585-F2-P3/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")

    common = b1_p3.intersection(b2_p3, b3_p3, d1_p3, f1_p3, f2_p3)
    print(len(common))

    all_neoantigens = b1_p3.union(b2_p3, b3_p3, d1_p3, f1_p3, f2_p3)

    outfile = open(
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/05_neoantigen_landscape/PS13-585_distant_tumors_upsetplot_input_neoantigens.csv",
        "w")
    header = ["variants", "B1-P3", "B2-P3", "B3-P3", "D1-P3", "F1-P3", "F2-P3"]
    print(",".join(header), file=outfile)

    files = [b1_p3, b2_p3, b3_p3, d1_p3, f1_p3, f2_p3]

    for i in all_neoantigens:
        out = [i]
        for file in files:
            if i in file:
                out.append("1")
            else:
                out.append("0")
        print(",".join(out), file=outfile)

    # All
    common = a1_p3.intersection(a2_p3, a3_p3, a3_p5, a4_p3, a4_p5, a5_p3, a6_p3, a7_p3, a8_p3, a8_p5, a9_p3, a10_p3, a10_p5, a10_p6, a11_p3, a11_p5, a12_p3, a12_p5, b2_p3, b3_p3, d1_p3, f1_p3, f2_p3)
    print(len(common))

    all_neoantigens = a1_p3.union(a2_p3, a3_p3, a3_p5, a4_p3, a4_p5, a5_p3, a6_p3, a7_p3, a8_p3, a8_p5, a9_p3, a10_p3, a10_p5, a10_p6, a11_p3, a11_p5, a12_p3, a12_p5, b2_p3, b3_p3, d1_p3, f1_p3, f2_p3)

    outfile = open(
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/05_neoantigen_landscape/PS13-585_all_tumors_upsetplot_input_neoantigens.csv",
        "w")
    header = ["variants", "A1-P3", "A2-P3", "A3-P3", "A3-P5", "A4-P3", "A4-P5", "A5-P3", "A6-P3", "A7-P3", "A8-P3", "A8-P5", "A9-P3", "A10-P3", "A10-P5", "A10-P6", "A11-P3", "A11-P5", "A12-P3", "A12-P5", "B1-P3", "B2-P3", "B3-P3", "D1-P3", "F1-P3", "F2-P3"]
    print(",".join(header), file=outfile)

    files = [a1_p3, a2_p3, a3_p3, a3_p5, a4_p3, a4_p5, a5_p3, a6_p3, a7_p3, a8_p3, a8_p5, a9_p3, a10_p3, a10_p5, a10_p6, a11_p3, a11_p5, a12_p3, a12_p5, b1_p3, b2_p3, b3_p3, d1_p3, f1_p3, f2_p3]

    for i in all_neoantigens:
        out = [i]
        for file in files:
            if i in file:
                out.append("1")
            else:
                out.append("0")
        print(",".join(out), file=outfile)

    # PS13-1962
    f3_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-9062F3-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    f4_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-9062F4-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    f5_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-9062F5-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")
    f6_p4 = return_set_of_neoantigens("/scratch/tphung3/Mayo_breast_regional_heterogeneity/03_neoantigens/run_mhcpan/PS13-9062F6-P4/all_hlas_9_mers_filtered_neoepitopes_no_tpm_clean.tsv")

    common = f3_p4.intersection(f4_p4, f5_p4, f6_p4)
    print(len(common))

    all_neoantigens = f3_p4.union(f4_p4, f5_p4, f6_p4)

    outfile = open(
        "/scratch/tphung3/Mayo_breast_regional_heterogeneity/05_neoantigen_landscape/PS13-9062_tumors_upsetplot_input_neoantigens.csv",
        "w")
    header = ["variants", "F3-P4", "F4-P4", "F5-P4", "F6-P4"]
    print(",".join(header), file=outfile)

    files = [f3_p4, f4_p4, f5_p4, f6_p4]

    for i in all_neoantigens:
        out = [i]
        for file in files:
            if i in file:
                out.append("1")
            else:
                out.append("0")
        print(",".join(out), file=outfile)

main()