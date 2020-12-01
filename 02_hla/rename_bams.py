import os

directory = '/data/kander22/MAYO_breastcancer/02_hla/remap_GRCh38_bams/'
for filename in os.listdir(directory):
    src = os.path.join(directory, filename)

    new_filename = filename.replace('-', '_')
    dst = os.path.join(directory, new_filename)
    os.rename(src, dst)

