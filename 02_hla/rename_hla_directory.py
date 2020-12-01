import os

directory = '/scratch/tphung3/Mayo_breast_regional_heterogeneity/02_hla/'
for name in os.listdir(directory):
    if name.startswith('PS13'):
        src = os.path.join(directory, name)
        new_name = name.replace('_', '-')
        dst = os.path.join(directory, new_name)
        os.rename(src, dst)
