library(UpSetR)
library(tidyverse)

# --------
# PS13-585
# --------

# Primary tumors
data <- read.csv("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/results/Ps13-585-A_tumors_upsetplot_input.csv", sep = ",")

png("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/plots/Ps13-585-A_tumors_upsetplot.png", width=17, height=14, units = "in", res = 300)
upset(data, 
      sets = c("A1.P3", "A2.P3", "A3.P3", "A3.P5", "A4.P3", "A4.P5", "A5.P3", "A6.P3", "A7.P3", "A8.P3", "A8.P5", "A9.P3", "A10.P3", "A10.P5", "A10.P6", "A11.P3", "A11.P5", "A12.P3", "A12.P5"), 
      point.size = 3.5, 
      line.size = 2,
      mainbar.y.label = "Variant Intersections", 
      sets.x.label = "Number of variants",
      text.scale = c(2, 1.75, 2, 1.75, 2, 2), 
      order.by = "freq", 
      keep.order = TRUE)
dev.off()

# Distant tumors
data <- read.csv("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/results/PS13-585_distant_tumors_upsetplot_input.csv", sep = ",")

png("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/plots/Ps13-585_distant_tumors_upsetplot.png", width=10, height=7, units = "in", res = 300)
upset(data, sets = c("B1.P3", "B2.P3", "B3.P3", "D1.P3", "F1.P3", "F2.P3"), point.size = 3.5, line.size = 2,
      mainbar.y.label = "Variant Intersections", sets.x.label = "Number of variants",
      text.scale = c(1.7, 1.7, 1.5, 1.5, 2.5, 1.5), order.by = "freq", keep.order = TRUE)
dev.off()

# All samples
data <- read.csv("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/results/Ps13-585-all_tumors_upsetplot_input.csv", sep = ",")

png("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/plots/Ps13-585-all_tumors_upsetplot.png", width=17, height=16, units = "in", res = 300)
upset(data, sets = c("A1.P3", "A2.P3", "A3.P3", "A3.P5", "A4.P3", "A4.P5", "A5.P3", "A6.P3", "A7.P3", "A8.P3", "A8.P5", "A9.P3", "A10.P3", "A10.P5", "A10.P6", "A11.P3", "A11.P5", "A12.P3", "A12.P5", "B1.P3", "B2.P3", "B3.P3", "D1.P3", "F1.P3", "F2.P3"), point.size = 3.5, line.size = 2,
      mainbar.y.label = "Variant Intersections", sets.x.label = "Number of variants",
      text.scale = c(2, 1.75, 2, 1.75, 2.2, 2.5), order.by = "freq", keep.order = TRUE)
dev.off()

png("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/plots/Ps13-585-all_tumors_upsetplot_09092020.png", width=17, height=14, units = "in", res = 300)
upset(data, sets = c("A1.P3", "A2.P3", "A3.P3", "A3.P5", "A4.P3", "A4.P5", "A5.P3", "A6.P3", "A7.P3", "A8.P3", "A8.P5", "A9.P3", "A10.P3", "A10.P5", "A10.P6", "A11.P3", "A11.P5", "A12.P3", "A12.P5", "B1.P3", "B2.P3", "B3.P3", "D1.P3", "F1.P3", "F2.P3"), point.size = 3.5, line.size = 2,
      mainbar.y.label = "Variant Intersections", sets.x.label = "Number of variants",
      text.scale = c(2, 1.75, 2, 1.75, 2.2, 2.5), order.by = c("degree", "freq"), keep.order = TRUE, nintersects = 40)
dev.off()

# ---------
# PS13-1750
# ---------

data <- read.csv("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/results/PS13-1750-A_tumors_upsetplot_input.csv", sep = ",")

png("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/plots/Ps13-1750-A_tumors_upsetplot.png", width=17, height=14, units = "in", res = 300)
upset(data, sets = c("A1.P4", "A2.P4", "A2.P5", "A3.P4", "A4.P4", "A5.P4", "A6.P4", "A7.P4", "A8.P4", "A9.P4", "A10.P4"), point.size = 3.5, line.size = 2, 
      mainbar.y.label = "Variant Intersections", sets.x.label = "Number of variants", 
      text.scale = c(2, 1.75, 2, 1.75, 2.2, 2.5), order.by = "freq", keep.order = TRUE)
dev.off()

# ---------
# PS13-1962
# ---------

data <- read.csv("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/results/PS13-1962_tumors_upsetplot_input.csv", sep = ",")

png("c://Users/tuyen/Documents/postdoc_asu/projects/Neoepitope/MAYO_breastcancer/04_mutational_landscape/plots/Ps13-1962_tumors_upsetplot.png", width=10, height=7, units = "in", res = 300)
upset(data, sets = c("F3.P4", "F4.P4", "F5.P4", "F6.P4"), point.size = 3.5, line.size = 2, 
      mainbar.y.label = "Variant Intersections", sets.x.label = "Number of variants", 
      text.scale = c(1.7, 1.7, 1.5, 1.5, 2.5, 1.5), order.by = "freq", keep.order = TRUE)
dev.off()