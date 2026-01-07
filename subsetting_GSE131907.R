library(Matrix)
library(readr)
library(data.table)

# Load the UMI matrix
umi <- readRDS("C:/Users/smart/Downloads/GSE131907_Lung_Cancer_raw_UMI_matrix.rds/GSE131907_Lung_Cancer_raw_UMI_matrix.rds")


# Load cell annotations
anno <- fread("C:/Users/smart/Downloads/GSE131907_Lung_Cancer_cell_annotation.txt/GSE131907_Lung_Cancer_cell_annotation.txt")

# Define your six samples
selected_samples <- c("LUNG_N06", "LUNG_N08", "LUNG_N28", "LUNG_T06", "LUNG_T08", "LUNG_T28")

anno_subset <- anno[Sample %in% selected_samples]

selected_cells <- anno_subset$Index

umi_subset <- umi[, selected_cells]

# Convert to sparse matrix
umi_sparse <- Matrix::Matrix(as.matrix(umi_subset), sparse = TRUE)


writeMM(umi_sparse, "GSE131907_subset_UMI.mtx")
write.csv(rownames(umi_sparse), "GSE131907_subset_genes.csv", row.names = FALSE)
write.csv(colnames(umi_sparse), "GSE131907_subset_barcodes.csv", row.names = FALSE)


list.files(pattern = "GSE131907_subset")




