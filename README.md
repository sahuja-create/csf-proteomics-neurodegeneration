# CSF Proteomics in Neurodegeneration

This repository contains the R code used for the proteomic analyses performed in our study of cerebrospinal fluid (CSF) biomarkers across healthy controls and neurodegenerative disease cohorts.

## Repository contents

- `01_run_dge (2).Rmd` – Differential protein expression analysis.
- `02_gsea_and_figures.Rmd` – Gene set enrichment analysis and figure generation.
- `bone_gene_list.txt` – Bone-related gene set.
- `senescence_gene_list.txt` – Senescence-related gene set.
- `focused_pathway_library.csv` – Custom pathway library used for enrichment analyses.
- `protein_metadata (1).csv` – Protein annotation metadata.
- `custom_panel_position.csv` – Figure formatting information.

## Data availability

The original patient-level proteomic and clinical data are **not included** in this repository to protect participant privacy.

The scripts are provided to document the complete analytical workflow and can be run using the appropriate input data.

## Software

Analyses were performed in **R version 4.5.1**.

## Private study exclusions and outputs

Reproducing the differential expression analysis requires the approved participant
exclusion list, in addition to the restricted clinical and proteomic inputs. The
list must be obtained through the study team's authorized data-access process.
It is not distributed with this code.

Store the list locally as `data/private/excluded_participant_ids.txt`, one
participant ID per line, or set the R environment variable `CSF_EXCLUSION_FILE`
to an approved private file. Do not upload the list or its contents to GitHub
or Zenodo. The analysis stops if the list is missing, empty, or does not match
the eligible cohort, rather than silently omitting the exclusions.

The private list must contain the original approved exclusions to preserve the
study cohort and results. Removing an identifier from public code must not
remove the exclusion from the analysis.

`data/`, `private/`, `results/`, and `figures/` are excluded from Git tracking.
The biomarker linkage check is written to
`results/associations/merged_lumipulse_check.csv`; this and `assoc_input.rds`
contain participant-level information and must remain private. Rendered
notebooks can also contain participant information and must be reviewed before
sharing. Git ignore rules do not remove files already committed to history.
