source("utils/data_gathering_utils.R")
load("data/OSF_preprocessed.RData")


# comment out not sure I need this may be used later for a function


#startdates <- movies$forecast_start
#startdates <- trunc(x = startdates, units = "days")
#films <- movies$title
#startdates_median <- startdates - as.difftime(tim = 52, units = "weeks")
startdate <- OSF_data$date[[1]]
enddate <- tail(OSF_data$date,1)

#enddates_median <- enddate + as.difftime(tim = 9, units = "weeks")

# Define anker terms 12 terms that are constant no matter what in Oregon area 
#will come back to this if we need to change it to eugene area
ankers <- c("facebook", "google","gmail","amazon","youtube","ebay","yahoo","netflix","google maps",
            "craigslist","fox news","cnn")


# Link first anker to its median
gt_anker1_median <- gtrends(
  keyword = ankers[1], geo = "US-OR", 
  time = paste(as.character(trunc(startdate, "months")), as.character(ceil(enddate, "months"))))
gt_anker1_median <- gt_anker1_median$interest_over_time
gt_anker1_median <- gt_anker1_median$hits / median(gt_anker1_median$hits)


for (i in 2:length(ankers)){
  assign(paste0("gt_anker", i-1, "_anker", i),
         export_gt_data(terms = ankers[i], startdates = startdate, enddates = enddate, anker = ankers[i-1]))
}

# Scale down anker terms
gt_anker1_anker2 <- gt_anker1_median * gt_anker1_anker2[, 4]


for (i in 3:length(ankers)){
  assign(paste0("gt_anker", 1, "_anker", i), 
         get(paste0("gt_anker", 1, "_anker", i-1)) * get(paste0("gt_anker", i-1, "_anker", i))[, 4])
}

save.image("data/gt_data_ankers.RData")


