library(tidyverse)
library(data.table)
library(readr)

# Read in the COSMIC non-coding variants file
cosmic <- read_tsv("CosmicNCV.tsv.gz", col_types = cols())

cosmic
cosmic_filtered <- cosmic %>% filter(str_detect(`Primary site`, "ovary"))

MIG_positions <- read_csv("MIG_positions.csv")

split_coords <- t(apply(cosmic_filtered["genome position"], 1, function(x) {
  strsplit(as.character(x), "[:-]")[[1]]
}))

split_coords_df <- as.data.frame(split_coords)
colnames(split_coords_df) <- c("chromosome", "start_pos", "stop_pos")

cosmic_ovary <- cosmic_filtered %>% mutate(split_coords_df)

overlap_data <- cosmic_ovary %>%
  inner_join(MIG_positions, by = "chromosome") %>%
  filter(start_pos >= gene_start & start_pos <= gene_stop)
View(overlap_data)

overlap_data$point_mutation <- substr(overlap_data$HGVSG, nchar(overlap_data$HGVSG) - 2, nchar(overlap_data$HGVSG))
mutation_freq <- table(overlap_data$point_mutation)
View(mutation_freq)

chroms <- table(overlap_data$chromosome)
View(chroms)





