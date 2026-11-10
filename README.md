# CSF Proteomics in Neurodegeneration

Analysis code for **CSF proteomics reveals bone remodeling and cellular senescence signatures across the Alzheimer's disease and Lewy body disease spectra**.

The repository contains R notebooks for differential protein expression, gene set enrichment, panel volcano plots, protein networks, and associations with clinical CSF biomarkers. Participant-level proteomic, demographic, clinical, and linkage data are restricted and are not included.

## Repository contents

| Path | Purpose |
| --- | --- |
| `scripts/00_install_dependencies.R` | Install required R packages and record the setup environment |
| `scripts/01_run_dge.Rmd` | Quality control, approved exclusions, and limma differential expression |
| `scripts/02_gsea_and_figures.Rmd` | Enrichment, figures, and clinical biomarker associations |
| `reference/bone_gene_list.txt` | Curated bone panel |
| `reference/senescence_gene_list.txt` | Curated senescence panel |
| `reference/protein_metadata.csv` | Public protein-level annotations; not the full input dictionary |
| `reference/published_outputs/` | Previously supplied aggregate pathway library and panel-rank tables; these are not regenerated during installation |
| `CITATION.cff` | Title, author order, and affiliations for citation metadata |
| `LICENSE` | MIT license for the code |

`data/`, `results/`, `figures/`, and `private/` are local directories excluded from Git tracking. See [STRUCTURE.md](STRUCTURE.md) for the complete layout.

## Software and installation

The reported analysis environment used **R 4.5.1**. RStudio is optional. Rendering HTML notebooks requires Pandoc, which is bundled with RStudio. From an R session with the repository root as the working directory:

```r
source("scripts/00_install_dependencies.R")
```

The installer uses CRAN and Bioconductor and needs internet access. It records the resulting environment in the private `results/setup_sessionInfo.txt`. Package versions were not provided in the original repository; this installer is not a reconstruction of the authors' exact historical environment. MSigDB resources obtained through `msigdbr` can change between versions. Preserve the installed package versions and gene-set versions when checking agreement with the manuscript.

## Restricted inputs

Obtain study inputs and the approved exclusion list through the study team's authorized data-access process. This repository does not grant access to those data. Contact the corresponding author, Vidyani Suryadevara, at vidyani@stanford.edu for study-specific access questions.

Create a local `data/` directory and provide the following files. Preserve the original identifiers and column names locally so the tables link correctly.

| File in `data/` | Expected contents used by the notebooks |
| --- | --- |
| `SADRC_CSF_SomaScan_sample_protein_expression_hybNorm.medNormInt.medNormRefSMP.anmlQC.anmlSMP_norm.csv` | `SampleId` and positive normalized protein-expression columns beginning with `SL` |
| `SADRC_CSF_SomaScan_sample_metadata.csv` | `SampleId`, `SampleType`, `PlateId`, `PlateRunDate`, `ScannerID`, `RowCheck` |
| `SADRC_CSF_basic_demographics.xlsx` | `SampleId`, `PIDN`, `Sex`, `Diagnosis_group` or `Diagnosis`, and `Age_years` or `Age`; the association section also requires `ADRC_ID` |
| `SADRC_CSF_SomaScan_protein_metadata_dict.csv` | `SomaKey`, `SomaId`, `Target`, `TargetFullName`, `UniProt`, `EntrezGeneSymbol` |
| `Wilson Data ADRC SAMS Lumipulse CSF Classification.xlsx` | Sheet `Combined_Data` with `Originating`, `ADRC_ID/Linkcode`, `CSF_P_Tau181`, `CSF Total Tau`, `CSF AB42`, `CSF AB40`, `CSF_AB42_AB40` |
| `private/excluded_participant_ids.txt` | Approved study exclusions, one participant ID per line |

The public protein annotation CSV is a derived annotation table and lacks the full dictionary schema required by Step 1. Do not rename it as the full input dictionary.

The exclusion list must contain the original approved exclusions to preserve the study cohort. It is deliberately absent from the public archive. Alternatively, set `CSF_EXCLUSION_FILE` to the path of an approved private exclusion file. Step 1 stops if the list is missing, empty, or does not match the eligible cohort; it must not be bypassed to produce results.

`Sex` must use the `F` and `M` coding expected by the within-group contrasts. The notebooks group diagnoses as HC; AD spectrum (`MCI`, `AD`); and LB spectrum (`PD`, `MCI-PD`, `LBD`). See the configuration and covariate sections before substituting other datasets.

## Run the analysis

From the repository root in R, after installing dependencies and providing approved inputs:

```r
dir.create("results/notebooks", recursive = TRUE, showWarnings = FALSE)
rmarkdown::render(
  "scripts/01_run_dge.Rmd",
  output_dir = normalizePath("results/notebooks"),
  envir = new.env(parent = globalenv())
)
rmarkdown::render(
  "scripts/02_gsea_and_figures.Rmd",
  output_dir = normalizePath("results/notebooks"),
  envir = new.env(parent = globalenv())
)
writeLines(capture.output(sessionInfo()), "results/analysis_sessionInfo.txt")
```

Run Step 1 before Step 2. Both notebooks detect the repository root from their location in `scripts/`. Public panels are read from `reference/`; restricted inputs are read from `data/`. Full execution of Step 2 requires the Lumipulse workbook as well as the Step 1 outputs.

Step 1 retains the earliest eligible visit per participant, applies a minimum baseline age of 55 years and the approved exclusions, and fits the existing fixed-effects limma models. Between-group models adjust for age and sex. Within-group male-versus-female models adjust for age.

The fitted between-group contrasts are **HC minus AD spectrum**, **HC minus LB spectrum**, and **AD spectrum minus LB spectrum**. Positive log fold change therefore means higher protein abundance in the first named group. Step 2 retains those directions when ranking and labeling results; it does not invert their effect signs. Within-group sex contrasts are male minus female. Enrichment uses the between-group tables; within-group sex tables are used by the panel volcano sections and are not female-only or male-only disease-versus-HC models.

## Outputs and confidentiality

- `results/dge/glm_combined_baseAge55/`: between-group tables, group counts, and derived annotations.
- `results/dge/glm_combined_baseAge55_sexcontrast/`: within-group male-versus-female tables.
- `results/dge/assoc_input.rds`: **restricted participant-level expression, covariates, and annotations**.
- `results/gsea/`: ranked lists, enrichment tables, and pathway summaries.
- `results/associations/`: association tables and the **restricted participant linkage check** `merged_lumipulse_check.csv`.
- `figures/`: panel plots, networks, enrichment figures, and association heatmaps.
- `results/notebooks/`: rendered notebooks, which must be treated as private until reviewed.

Do not upload participant-level inputs, exclusion IDs, linkage checks, RDS objects, or unreviewed rendered notebooks to GitHub or Zenodo. Ignore rules reduce accidental additions; they do not remove data already tracked by Git or make outputs safe for public release. Review every file intended for archiving.

## Validation and reproducibility

Repository preparation checks cover notebook syntax, public reference paths, result discovery, contrast labels, and ignore rules. The full analysis has not been rerun as part of this preparation because restricted inputs are unavailable. No claim is made that newly generated figures have been matched to the final manuscript. The study team should rerun with its approved inputs and original environment before treating outputs as verified reproductions.

## Citation and license

Use `CITATION.cff` for the author metadata. After Zenodo archives a release, cite the **version-specific DOI** for the code version used in the manuscript. A DOI has not yet been added here.

The code is provided under the MIT license; see `LICENSE`. The license does not grant access to restricted study data. Third-party annotations and gene-set resources remain subject to their applicable source terms.
