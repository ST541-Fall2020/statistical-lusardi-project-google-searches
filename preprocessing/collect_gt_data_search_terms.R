load("data/OSF_preprocessed.RData")
load("data/gt_data_ankers.RData")
source("utils/data_gathering_utils.R")

# Gather data for the main title of the movie  ========================================================================
terms <- main_title
levels_idx <- 1:length(terms)
for (i in 1:length(ankers)){
  cat("Collecting data for anker term" ,i, "of", length(ankers),"\n")
  if (length(terms) > 0){
    # Pull Google Trends data with current anker
    x <- export_gt_data(terms = terms, startdates = startdate, enddates = enddate, anker = ankers[i])
    colnames(x)[4:ncol(x)] <- gsub(terms, pattern = " ", replacement = "_")
    
    last_forecast_date <- last_forecast_date[levels_idx]
    # Detect terms that have to be redrawn
    levels <- detect_low_level_terms(terms = terms, trends = x, enddate = last_forecast_date)
    levels_idx <- levels$low
    terms <- terms[levels_idx]
    
    assign(paste0("gt_data", i), x)
    
    save.image("data/gt_data_main_title.RData")
  }
}