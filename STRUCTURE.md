# Project layout

| Directory | Tracked publicly | Contents |
| --- | --- | --- |
| `scripts/` | Yes | Dependency installer and analysis notebooks |
| `reference/` | Yes | Curated panels and derived protein annotations |
| `reference/published_outputs/` | Yes | Previously supplied aggregate enrichment reference tables |
| `data/` | No | Restricted clinical/proteomic inputs and full input dictionary |
| `data/private/` | No | Approved exclusion list |
| `results/dge/` | No | Differential expression tables and participant-level RDS |
| `results/gsea/` | No | Generated enrichment results |
| `results/associations/` | No | Biomarker association results and participant linkage check |
| `results/notebooks/` | No | Rendered notebooks |
| `figures/` | No | Generated figures pending review |

The repository root contains `README.md`, `STRUCTURE.md`, `CITATION.cff`, and `LICENSE`.
Local input and output directories are created during setup or analysis and are not part of the archive.
