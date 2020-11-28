# Load Google Trends data
load("data/gt_data_main_search_terms.RData")
load("data/OSF_preprocessed.RData")

# Source functions
source("utils/preprocessing_utils.R")





save.image("data/concatenated_data.RData")
