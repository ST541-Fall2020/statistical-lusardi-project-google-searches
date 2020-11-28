# Load Google Trends data
load("data/gt_data_complete.RData")
load("data/OSF_preprocessed.RData")

# Source functions
source("utils/preprocessing_utils.R")

startdates <-as.Date(startdate)
enddates <- as.Date(startdate+52)

#setting end date as 6 weeks from the start date

# Main Title ===========================================================================================================
# Filter for median before forecasting window
#row_median <- calculate_median(trends = gt_data_main_search_terms, enddates = enddates, 
 #                              terms = gt_data_main_search_terms$`search term`, frame = 52)
#row_median[is.na(row_median)] <- 0
#gt_data_main_title[, -1] <- gt_data_main_title[, -1] - row_median

# Filter for relevant Google Trends Data
main_search_terms_final <- select_gt_data(trends = gt_data_main_search_terms, 
                                          enddates = enddates, terms = gt_data_main_search_terms$`search term`)
terms=gt_data_main_search_terms$`search term`
trends = gt_data_main_search_terms
trends = as.matrix(trends[, -1])
data = matrix(nrow = nrow(trends), ncol = 6)
data_aggregated = matrix(nrow = nrow(trends), ncol = 6)

end = which(as.character(enddates[]) == colnames(trends))
colnames(trends)

end
start=end-5
start:end

data
for(i in seq_along(terms)) {
  end = which(as.character(enddates[i]) == colnames(trends))
  start = end - 5
  data[i, ] = trends[i, start:end]
}


colnames(main_title_final) <- c("title", paste0("week", 6:1, "_main_title"), 
                                
                                
                      
                                paste0("aggregation", 6:1, "_main_title"))
head(main_title_final)








# Concatenate data
data_final <- cbind(movies, main_title_final[, -1], complete_title_final[, -1], main_title_film_final[, -1], kino_data)

rm(list = ls()[which(!(ls() %in% c("data_final")))])
save.image("data/concatenated_data.RData")