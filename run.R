#!/usr/bin/env Rscript

library(argparse)

# Parse command line arguments
parser <- ArgumentParser(description="OmniBenchmark module")

#        parameters:
#            - dataset: "1.3m"
#              subset: [0.25, 0.50, 0.75, 1.0]
#              format: ["h5ad","mm","files"]


# Required by OmniBenchmark
parser$add_argument("--output_dir", dest="output_dir", type="character", required=TRUE,
                   help="Output directory for results")
parser$add_argument("--name", dest="name", type="character", required=TRUE,
                   help="Module name/identifier")
parser$add_argument("--dataset", dest = "dataset", type = "character",
		    help = "name of the dataset", choices = c("1.3m"), 
		    required = TRUE)
parser$add_argument("--subset", dest = "subset", type = "numeric",
		    help = "how much to subset the dataset", required = TRUE)
parser$add_argument("--format", dest = "format", type = "character",
		    help = "format of the output", required = TRUE)

args <- parser$parse_args()

cat("Output directory:", args$output_dir, "\n")
cat("Module name:", args$name, "\n")
cat("Subset:", args$subset, "\n")
cat("Dataset:", args$dataset, "\n")
cat("Format:", args$format, "\n")

library(SingleCellExperiment)

out_path <- file.path(args$output_dir, paste0(args$name, ".out"))
json_path <- file.path(args$output_dir, paste0(args$name, ".json"))

if (args$dataset == "1.3m") {
  # fetch 10x 1.3M data
  library(TENxBrainData)
  sce <- TENxBrainData()
  rownames(sce) <- rowData(sce)$Symbol
}

# write outputs
if (args$format == "h5ad") {
  library(anndataR)
  write_h5ad(sce, out_path)
}

