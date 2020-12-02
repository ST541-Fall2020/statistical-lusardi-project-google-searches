# Google Searches

Name: Anthony Lusardi

<!-- badges: start -->
<!-- badges: end -->

### Overview and Motivation

-------------------------------------------------------------------------------------------------

What I hope to complete with this project is to use available data collected on [google searches](https://trends.google.com/trends/?geo=US) for a restaurant title to then generate a linear regression model to predict the average amount of guests expected to come in on a given day.

Initially it was a far-fetched idea however, I had found In a [previous study](https://towardsdatascience.com/using-google-trends-data-to-leverage-your-predictive-model-a56635355e3d) in 2019, a researcher had been able to predict the forecasted visitors on opening night for a movie theater based on the google searches for the movie title in a geographic area. It was a simple idea that proved to be very successful for consulting a movie theater company in Germany.


### Data gathering -preprocessing and data analysis

-------------------------------------------------------------------------------------------------

The provided [dataset](https://github.com/ST541-Fall2020/statistical-lusardi-project-google-searches/blob/master/data/OSF_data_source_0.csv) contains key data for recorded guest activity at the Old Spaghetti Factory (OSF) in Corvallis OR, between 01/01/2018 and 12/31/2019. It contains 17 features ,described [here](https://github.com/ST541-Fall2020/statistical-lusardi-project-google-searches/blob/master/reports/Table%20of%20figures%20and%20features.pdf), of key data associated with predicted guest activity such as guest counts from the previous years, managers predictions, and six week trends. The guest counts for dinner will be the target variable that will be predicted.


After preprocessing of the raw OSF data is done in this [script](https://github.com/ST541-Fall2020/statistical-lusardi-project-google-searches/blob/master/preprocessing/preprocess_OSF_data.R) the Google Trends data will be collected and preprocessed. 

The order how to run the scripts to gather and preprocess the Google Trends data is

* Collecting the Google Trends data for the anchor terms running this [script](https://github.com/ST541-Fall2020/statistical-lusardi-project-google-searches/blob/master/preprocessing/collect_gt_data_anchors.R)
* Collecting and scaling the Google Trends data for the defined search terms running this [script](https://github.com/ST541-Fall2020/statistical-lusardi-project-google-searches/blob/master/preprocessing/collect_gt_data_search_terms.R)

For data analysis and testing following an html document here (insert link) it was used using a Using a program called exploratory note 

### Report and Presentation

-------------------------------------------------------------------------------------------------
* The slides can be found here for the presentation (insert link)
* The final report on results can be found [here](https://github.com/ST541-Fall2020/statistical-lusardi-project-google-searches/blob/master/reports/Report_final.pdf) 


