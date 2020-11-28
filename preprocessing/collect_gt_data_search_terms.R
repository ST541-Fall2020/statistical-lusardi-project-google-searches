load("data/OSF_preprocessed.RData")
load("data/gt_data_ankers.RData")
source("utils/data_gathering_utils.R")


startdate<-trunc(startdate,"days")
enddate<-trunc(enddate,"days")

last_forecast_date<-as.POSIXct(last_forecast_date$date)
last_forecast_date<-trunc(last_forecast_date,"days")





terms <- c("the old spaghetti factory","spaghetti factory","spaghetti factory corvallis","old spaghetti factory","italian food",
           "dinner near me","trolley restaurant","dine in","Pastinis")

levels_idx <- 1:length(terms)
# Gather data for the main titles for searchs of OSF and every anchor term ========================================================================

  for (i in 1:length(ankers)){
  cat("Collecting data for anker term" ,i, "of", length(ankers),"\n")
  if (length(terms) > 0){
    # Pull Google Trends data with current anker
    x <- export_gt_data(terms = terms, startdates = startdate, enddates = enddate, anker = ankers[i])
    colnames(x)[4:ncol(x)] <- gsub(terms, pattern = " ", replacement = "_")
    
    #last_forecast_date <- last_forecast_date[levels_idx]
    # Detect terms that have to be redrawn
    #levels <- detect_low_level_terms(terms = terms, trends = x, enddate = last_forecast_date)
    #levels_idx <- levels$low
    #terms <- terms[levels_idx]
    
    assign(paste0("gt_data", i), x)
    
    save.image("data/gt_data_main_search_terms.RData")
  }
}


# Scale down search terms
x <- scale_down(upper_gt = gt_data1, lower_gt = gt_data1, scale_gt = gt_anker1_median)
for (i in 2:length(ankers)){
  x <- scale_down(upper_gt = x, lower_gt = get(paste0("gt_data", i)), scale_gt = get(paste0("gt_anker1_anker", i)))
}
x
# Build final Google Trends dataset
gt_data_main_search_terms <- x
gt_data_main_search_terms<-gt_data_main_search_terms[,c(-2,-3)]
colnames(gt_data_main_search_terms)[1]<-c("dates")
gt_data_main_search_terms

save.image("data/gt_data_main_search_terms.RData")

