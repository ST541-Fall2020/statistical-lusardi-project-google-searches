source("utils/data_gathering_utils.R")
load("data/gt_data_main_search_terms.RData")
load("data/OSF_preprocessed.RData")

# Prep for linear model



`gt_data_main_search_terms_2` <-  exploratory::getObjectFromRdata("data/gt_data_main_search_terms.RData"
                                                                  ,"gt_data_main_search_terms") %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame()



# Steps to produce the output
lm_build<-exploratory::getObjectFromRdata("data/OSF_preprocessed.RData","OSF_data") %>%
  readr::type_convert() %>%
  exploratory::clean_data_frame() %>%
  mutate(din_ly = parse_number(din_ly)) %>%
  summarize_group(group_cols = c(`date_week` = "date"),group_funs = c("rtoweek"),din_ly_sum = sum(din_ly, na.rm = TRUE),
                  guest_count_dinner_sum = sum(guest_count_dinner, na.rm = TRUE),ppl_res_din_sum = sum(ppl_res_din, na.rm = TRUE),
                  temp_avg_mean = mean(temp_avg, na.rm = TRUE),month_unq = n_distinct(month),season_unq = n_distinct(season)) %>%
  mutate(date_week = as_date(date_week)) %>%
  left_join(gt_data_main_search_terms_2, by = c("date_week" = "dates")) %>%
  mutate(temp_avg_mean = round(temp_avg_mean,1)
  ) %>%
  mutate_at(vars(Pastinis, trolley_restaurant, ppl_res_din_sum, din_ly_sum, 
                 guest_count_dinner_sum, spaghetti_factory_corvallis, the_old_spaghetti_factory, 
                 old_spaghetti_factory, spaghetti_factory, italian_food, dinner_near_me, dine_in), funs(normalize))


# build Linear model
lm1<-build_lm(guest_count_dinner_sum ~ date_week + din_ly_sum + temp_avg_mean + ppl_res_din_sum, test_rate = 0.6, data = lm_build)

#clean data
view(lm1)
