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
gt_data_main_search_terms <- as.data.frame(t(gt_data_main_search_terms[,4:ncol(gt_data_main_search_terms)]))
gt_data_main_search_terms
colnames(gt_data_main_search_terms) <- gt_data1[, 2]
rownames(gt_data_main_search_terms) <- 1:nrow(gt_data_main_search_terms)

terms

names_upper <- colnames(upper_gt[, -c(1:3)])
names_lower <- colnames(lower_gt[, -c(1:3)])
lower_gt <- lower_gt[, -c(1:3)]

scale_id <- which(names_upper %in% names_lower)


gt_data_main_search_terms <- cbind("title" = terms, gt_data_main_search_terms)
head(gt_data_main_search_terms)
rm(list = ls() [which(ls() != "gt_data_main_search_terms")])
save.image("data/gt_data_main_search_terms.RData")


# Build final Google Trends dataset
#gt_data_main_title_film <- x
#gt_data_main_title_film <- as.data.frame(t(gt_data_main_title_film[,4:ncol(gt_data_main_title_film)]))
#colnames(gt_data_main_title_film) <- gt_data1[, 2]
#rownames(gt_data_main_title_film) <- 1:nrow(gt_data_main_title_film)
#gt_data_main_title_film <- cbind("title" = movies$title, gt_data_main_title_film)
#head(gt_data_main_title_film)
#rm(list = ls() [which(ls() != "gt_data_main_title_film")])


## collect actual terms of interest
# Filter for relevant Google Trends Data
main_title_final <- select_gt_data(trends = gt_data_main_title, enddates = enddates, terms = gt_data_main_search_terms$title)
colnames(main_title_final) <- c("title", paste0("week", 6:1, "_main_title"), 
                                paste0("aggregation", 6:1, "_main_title"))
head(main_title_final)

save.image("data/gt_data_complete.RData")
