source("utils/preprocessing_utils.R")
library(readr)
library(tidyverse)

movies <- read.csv("data/movies.csv", sep = ";", dec = ",", comment.char = "", encoding = "UTF-8", na.strings = "")
movies$premiere_date = as.POSIXct(movies$premiere_date, format = "%d.%m.%y", tz = "GMT")
movies$title <- as.character(movies$title)
movies$genre <- as.character(movies$genre)
movies$rating <- as.factor(movies$rating)
movies$kids_movie <- as.factor(ifelse(test = movies$kids_movie == "yes", yes = 1, no = 0))


# import guest count data


OSF_data <- read_csv("data/OSF_data_source_0.csv", 
                              col_types = cols(`6_week_din` = col_double(), 
                                               `6_week_lun` = col_double(), date = col_date(format = "%m/%d/%Y"), 
                                               din_2y = col_double(), dinner_sales = col_number(), 
                                               guest_count_lunch = col_double(), 
                                               lunch_sales = col_number(), ppl_res_din = col_double(), 
                                               ppl_res_lun = col_double(), pred_din = col_double(), 
                                               pred_lunch = col_double(), temp_avg = col_number()))
View(OSF_data)



# throw out columns with irrelvant data keep guest counts dates and reservations
indexes<-c(1,3,6,7,8,14,16,17)
OSF_data<-OSF_data[indexes]

head(OSF_data)

# Use dates that have full data for all entries from March 1st 2018 to March 1st 2019

OSF_data %>%
  select(date,special_event,lun_ly,din_ly,din_2y,guest_count_dinner,ppl_res_din,temp_avg) %>%
  filter(date >=as.Date("2018-03-01") & date<=as.Date("2019-03-01"))

# Add studio category
major <- c("20th Century Fox", "Paramount Pictures", "Sony Pictures Releasing", "Universal Pictures", "Walt Disney",
           "Warner Bros.")
major_independent <- c("Concorde", "Constantin Film", "DCM", "Majestic (Fox)", "NFP (Warner)", "Senator", "Studiocanal",
                       "Tobis", "Universum Film", "Wild Bunch", "X Verleih")
independent <- c("Alamode Film", "Alpenrepublik", "Arsenal (Central)", "Arts Alliance", "Ascot Elite", "Barnsteiner",
                 "Camino","Capelight", "Central Film", "Delphi Filmverleih", "Falcom", "Farbfilm", "Koch Media", 
                 "KSM GmbH", "Maerchenfilm", "MFA+ Filmdistribution", "Movienet", "Neue Visionen", "NFP", "Pandastorm",
                 "Pandora", "polyband", "Port-au-Prince", "Pro-Fun", "Prokino", "Splendid", "SpotOn Distribution",
                 "Studio Hamburg", "Summiteer Films","Tiberius Film", "Weltkino", "Zorro")
movies$studio <- as.factor(ifelse(movies$studio %in% major, "major",
                                  ifelse(movies$studio %in% major_independent, "major_independent", "independent")))
# took log of visitors overall and the premiere weekend
movies$visitors_premiere_weekend_log <- log(movies$visitors_premiere_weekend)
movies$visitors_overall_log <- log(movies$visitors_overall)


#REMOVE FORECAST DATES do not need to mathc dates with premiers

# Add forecast horizon dates align google data with the actual dates
movies$forecast_start <- do.call(what = c, args = lapply(X = movies$premiere_date, FUN = forecast_date, forecast = 7)) +
  as.difftime(tim = 1, units = "days")
movies$forecast_date6 <- do.call(what = c, args = lapply(X = movies$premiere_date, FUN = forecast_date, forecast = 6))
movies$forecast_date5 <- do.call(what = c, args = lapply(X = movies$premiere_date, FUN = forecast_date, forecast = 5))
movies$forecast_date4 <- do.call(what = c, args = lapply(X = movies$premiere_date, FUN = forecast_date, forecast = 4))
movies$forecast_date3 <- do.call(what = c, args = lapply(X = movies$premiere_date, FUN = forecast_date, forecast = 3))
movies$forecast_date2 <- do.call(what = c, args = lapply(X = movies$premiere_date, FUN = forecast_date, forecast = 2))
movies$forecast_date1 <- do.call(what = c, args = lapply(X = movies$premiere_date, FUN = forecast_date, forecast = 1))

# Replace "&" with "und" for german movies and "and" for english ones
movies$title[c(67, 95, 151, 236, 559, 608, 621, 826, 836, 846)] <-
  gsub(movies$title[c(67, 95, 151, 236, 559, 608, 621, 826, 836, 846)], pattern = "&", replacement = "and")
movies$title[c(84, 97, 280, 286, 293, 486, 506, 727, 771, 894)] <-
  gsub(movies$title[c(84, 97, 280, 286, 293, 486, 506, 727, 771, 894)], pattern = "&", replacement = "und")

# Correct some movvie titles:
movies$title[788] <- "Tschiller: Off Duty"
movies$title[572] <- "Dessau Dancers"

# Remove "Eine Taube sitzt auf einem Zweig und denkt über das Leben nach" und "#Zeitgeist" aus dem Datensatz:
movies <- movies[-491, ]
movies <- movies[-479,]

# Get end of forecast horizon
last_forecast_date <- do.call(what = c, args = lapply(X = movies$premiere_date, FUN = forecast_date, forecast = 1))
last_forecast_date <- trunc(x = last_forecast_date, units = "days")


#CHANGE TO THREE KEYWORDS


# Define searchterms for Google Trends
main_title <- define_searchterms(movies$title)[[1]]
main_title_film <- define_searchterms(movies$title)[[2]]
complete_title <- define_searchterms(movies$title)[[3]]
movies$main_title <- main_title
movies$secondary_title <- as.factor(ifelse(test = main_title == complete_title, yes = 0, no = 1))

movies$words <- sapply(X = strsplit(x = movies$main_title, split = " "), FUN = length)
movies$month <- factor(strftime(movies$premiere_date, format = "%b"))
movies$month <- factor(movies$month, levels = unique(movies$month))

movies$season <- as.factor(ifelse(test = movies$month %in% c("Okt", "Nov", "Dez", "Jan", "Feb", "Mär"), 
                                  yes = "winter", no = "summer"))
movies$year_even <- as.numeric(strftime(x = movies$premiere_date, format = "%y"))
movies$odd_year <- as.factor(ifelse(test = movies$year_even %% 2 == 0, yes = 1, no = 0))

# Concatenate genres "Fantasy" and "Teenager-Film":
movies$genre[movies$genre == "Fantasy"] <- "TeenagerMovie_Fantasy"
movies$genre[movies$genre == "TeenagerMovie"] <- "TeenagerMovie_Fantasy"
movies$genre <- as.factor(movies$genre)

remove(major, major_independent, independent, forecast_date, calculate_box_cox,
       calculate_google_value, calculate_median, cross_validate_inner, define_searchterms, estimate_box_cox,
       optim_weights, select_gt_data)
save.image("data/OSF_preprocessed.RData")