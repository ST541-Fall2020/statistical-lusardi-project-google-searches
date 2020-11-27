source("utils/preprocessing_utils.R")



# import guest count data collected from OSF
OSF_data <- read_csv("data/OSF_data_source_0.csv", 
                     col_types = cols(`6_week_din` = col_double(), 
                                      `6_week_lun` = col_double(), date = col_date(format = "%m/%d/%Y"), 
                                      din_2y = col_double(), dinner_sales = col_number(), 
                                      guest_count_lunch = col_double(), 
                                      lunch_sales = col_number(), ppl_res_din = col_double(), 
                                      ppl_res_lun = col_double(), pred_din = col_double(), 
                                      pred_lunch = col_double(), temp_avg = col_number()))
head(OSF_data)

OSF_data$date = as.POSIXct(OSF_data$date, format = "%d.%m.%y")


str(OSF_data$date)
tail(OSF_data$date,1)
# throw out columns with irrelvant data keep guest counts dates and reservations
indexes<-c(1,3,6,7,8,14,16,17)
OSF_data<-OSF_data[indexes]

# Use dates that have full data for all entries from March 1st 2018 to March 1st 2019

OSF_data <-OSF_data %>%
  select(date,special_event,lun_ly,din_ly,din_2y,guest_count_dinner,ppl_res_din,temp_avg) %>%
  filter(date >=as.Date("2018-03-01") & date<=as.Date("2019-03-01"))
# take log of guest counts overall 
OSF_data <-OSF_data %>%
  mutate(gc_log=log(guest_count_dinner,),)


# Get end of forecast horizon
last_forecast_date <- OSF_data %>%
  select(date)%>% tail(,n=1)

# add seasonality factors
OSF_data$month <- factor(strftime(OSF_data$date, format = "%b"))
OSF_data$season<- as.factor(ifelse(test = OSF_data$month %in% c("Oct", "Nov", "Dec", "Jan", "Feb", "Mar"), 
                                   yes = "winter", no = "summer"))

OSF_data



#CHANGE TO THREE KEYWORDS took keywords from google trends to find the most popular search terms 
# the function define search terms is not necessary because of this


# Define searchterms for Google Trends this will be changed to just three search entries not 800 movies 
#main_title <- define_searchterms(movies$title)[[1]]
#main_title_film <- define_searchterms(movies$title)[[2]]
#complete_title <- define_searchterms(movies$title)[[3]]

#downloading a csv of the search term history from selected dates on three search terms from Eugene OR


save.image("data/OSF_preprocessed.RData")

