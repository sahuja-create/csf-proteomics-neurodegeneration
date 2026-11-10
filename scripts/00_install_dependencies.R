# Run from the repository root with R 4.5.1 (the reported analysis version).
cran <- c("rmarkdown", "knitr", "readr", "readxl", "dplyr", "tibble", "tidyr",
          "stringr", "purrr", "ggplot2", "ggrepel", "patchwork", "msigdbr",
          "circlize", "forcats", "igraph", "ggraph", "matrixStats", "BiocManager")
missing <- cran[!vapply(cran, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) install.packages(missing, repos = "https://cloud.r-project.org")
bioc <- c("limma", "fgsea", "ComplexHeatmap")
missing <- bioc[!vapply(bioc, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) BiocManager::install(missing, update = FALSE, ask = FALSE)
dir.create("results", showWarnings = FALSE)
writeLines(capture.output(sessionInfo()), "results/setup_sessionInfo.txt")
