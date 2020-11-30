# Google Searches

Name: Anthony Lusardi

<!-- badges: start -->
<!-- badges: end -->

### Overview and Motivation

What I hope to complete with this project is to use available data collected on google searches to answer questions about restaurant business patterns. By using search patterns a relationship could be drawn from the amount of traffic activity online with the amount of clientle the restaurant receives at dinner time.

If this proves to be correct, I can generate a linear regression model to predict the average amount of guests expected to come in on a given day based on the web searches collected from local areas.

Because Google Trends has data that is scaled relative to its search activity within the area, I need to create a system of normalizing this data with itself from a scale of 0 to 1. I also need to normalize the Guest count and reservation data to do the same. Part of this process will include working with code that will use weighting function to assign a relative value of a Google search in relation with all searches in the area. 

Once the data is combined, I seek to find a correlation between the provided variables. If the relationship is strong I will generate a linear regression model to predict the amount of guests based on Google searches.

Data gathering, -preprocessing and data analysis

The provided dataset contains key data for recorded guest activity at the Old Spaghetti Factory (OSF) in Corvallis OR, between 01/01/2018 and 12/31/2019. It contains 17 features of key data associated with predicted guest activity such as guest counts from the previous years, managers predictions, and six week trends. The guest counts for dinner will be the target variable that will be predicted.

|Feature name |Description|
|-----|--------|
|`date` | YMD of recorded data
|`day_week`| Day of the week
|`special_event`| Recorded if there were special events such as athletic events or school graduations
|`6_week_lun`| the 6 week trend of average guest counts for that week day at lunch
|`6_week_din`| the 6 week trend of average guest counts for that week day at dinner
|`lun_ly`| last years guests for lunch shifted for the day of the week (date-1,incomplete) 
|`din_ly`|last years guests for dinner shifted for the day of the week (date-1, incomplete)
|`din_2y`|two years ago guests for dinner shifted for the day of the week (date-2, incomplete)
|`pred_lunch`| The managers educated guess as to the amount of guest counts expected for that day at lunch
|`pred_din`|The managers educated guess as to the amount of guest counts expected for that day at dinner
|`lunch_sales`| Total sales at lunch that day (incomplete)
|`dinner_sales`| Total sales of dinner that day (incomplete)
|`guest_count_lunch`| Total guests for lunch for the given day
|`guest_count_dinner`| Total guests for dinner for the given day
|`ppl_res_lun`| Total people that are in reservations for lunch on the given day
|`ppl_res_din`| Total people that are in reservations for dinner on the given day
|`temp_avg`| The average Temperature for the day 



After preprocessing of the raw OSF data is done in this script the Google Trends data will be collected and preprocessed. I recommend reading more on how we preprocessed the data in this article.

The order how to run the scripts to gather and preprocess the Google Trends data is

* Collecting the Google Trends data for the anchor terms running this script(insert link)
* Collecting and scaling the Google Trends data for the defined search terms running this script(insert link)
* 

For the search terms we defined 12 search terms that were keywords and related to google searches for the term "the old spaghetti factory" such as "trolley restaurant" or "spaghetti factory"


### 
