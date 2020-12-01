# Google Searches

Name: Anthony Lusardi

<!-- badges: start -->
<!-- badges: end -->

### Overview and Motivation

-------------------------------------------------------------------------------------------------

What I hope to complete with this project is to use available data collected on google searches to answer questions about restaurant business patterns. By using search patterns a relationship could be drawn from the amount of traffic activity online with the amount of clientle the restaurant receives at dinner time. If this proves to be correct, I can generate a linear regression model to predict the average amount of guests expected to come in on a given day based on the web searches collected from local areas.

#### Collecting data from a Data Monopoly
Google has a strict hold on their data and especially to the data that matters the most as a result there has been some successful ways to collect this data using scaling search volume for constant keywords to isolate activity on keywords of interest. There is more of this method mentioned in this paper (insert link) 

#### Normalize the data. 
Because Google Trends has data that is scaled relative to its search activity within the area, I need to create a system of normalizing this data with itself from a scale of 0 to 1. I also need to normalize the Guest count and reservation data to do the same. Part of this process will include working with code that will use weighting function to assign a relative value of a Google search in relation with all searches in the area. 

Once the data is combined, I seek to find a correlation between the provided variables. If the relationship is strong I will generate a linear regression model to predict the amount of guests based on Google searches.

### Data gathering -preprocessing and data analysis

-------------------------------------------------------------------------------------------------

The provided dataset contains key data for recorded guest activity at the Old Spaghetti Factory (OSF) in Corvallis OR, between 01/01/2018 and 12/31/2019. It contains 17 features of key data associated with predicted guest activity such as guest counts from the previous years, managers predictions, and six week trends. The guest counts for dinner will be the target variable that will be predicted.


After preprocessing of the raw OSF data is done in this script(insert link) the Google Trends data will be collected and preprocessed. I recommend reading more on how we preprocessed the data in this report.

The order how to run the scripts to gather and preprocess the Google Trends data is

* Collecting the Google Trends data for the anchor terms running this script(insert link)
* Collecting and scaling the Google Trends data for the defined search terms running this script(insert link)

For data analysis and testing following an html document here (insert link) it was used using a Using a program called exploratory note 

### Report and Presentation

-------------------------------------------------------------------------------------------------
* The slides can be found here for the presentation (insert link)
* The final report on results can be found here (insert link)


