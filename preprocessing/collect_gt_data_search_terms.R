load("data/OSF_preprocessed.RData")
load("data/gt_data_ankers.RData")
source("utils/data_gathering_utils.R")

startdate<-as.POSIXct.Date(startdate)
startdate<-trunc(startdate,"days")
enddate<-trunc(enddate,"days")

last_forecast_date<-as.POSIXct(last_forecast_date$date)
last_forecast_date<-trunc(last_forecast_date,"days")


# Gather data for the main titles for searchs of OSF  ========================================================================



terms <- c("the old spaghetti factory","spaghetti factory","spaghetti factory corvallis","old spaghetti factory","italian food",
           "dinner near me","trolley restaurant","dine in","Pastinis")

levels_idx <- 1:length(terms)
  for (i in 1:length(ankers)){
  cat("Collecting data for anker term" ,i, "of", length(ankers),"\n")
  if (length(terms) > 0){
    # Pull Google Trends data with current anker
    x <- export_gt_data(terms = terms, startdates = startdate, enddates = enddate, anker = ankers[i])
    colnames(x)[4:ncol(x)] <- gsub(terms, pattern = " ", replacement = "_")
    
    last_forecast_date <- last_forecast_date[levels_idx]
    # Detect terms that have to be redrawn
    #levels <- detect_low_level_terms(terms = terms, trends = x, enddate = last_forecast_date)
    #levels_idx <- levels$low
    #terms <- terms[levels_idx]
    
    assign(paste0("gt_data", i), x)
    
    save.image("data/gt_data_main_title.RData")
  }
}

# Scale down search terms
x <- scale_down(upper_gt = gt_data1, lower_gt = gt_data1, scale_gt = gt_anker1_median)
for (i in 2:length(ankers)){
  x <- scale_down(upper_gt = x, lower_gt = get(paste0("gt_data", i)), scale_gt = get(paste0("gt_anker1_anker", i)))
}

# Build final Google Trends dataset
gt_data_main_title <- x
gt_data_main_title <- as.data.frame(t(gt_data_main_title[,4:ncol(gt_data_main_title)]))
colnames(gt_data_main_title) <- gt_data1[, 2]
rownames(gt_data_main_title) <- 1:nrow(gt_data_main_title)


gt_data_main_title <- cbind("title" = movies$title, gt_data_main_title)
head(gt_data_main_title)
rm(list = ls() [which(ls() != "gt_data_main_title")])
save.image("data/gt_data_main_title.RData")


# Build final Google Trends dataset
gt_data_main_title_film <- x
gt_data_main_title_film <- as.data.frame(t(gt_data_main_title_film[,4:ncol(gt_data_main_title_film)]))
colnames(gt_data_main_title_film) <- gt_data1[, 2]
rownames(gt_data_main_title_film) <- 1:nrow(gt_data_main_title_film)
gt_data_main_title_film <- cbind("title" = movies$title, gt_data_main_title_film)
head(gt_data_main_title_film)
rm(list = ls() [which(ls() != "gt_data_main_title_film")])


## collect actual terms of interest
# Filter for relevant Google Trends Data
main_title_final <- select_gt_data(trends = gt_data_main_title, enddates = enddates, terms = gt_data_main_title$title)
colnames(main_title_final) <- c("title", paste0("week", 6:1, "_main_title"), 
                                paste0("aggregation", 6:1, "_main_title"))
head(main_title_final)

save.image("data/gt_data_complete.RData")
