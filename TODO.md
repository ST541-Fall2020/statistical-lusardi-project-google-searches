# Milestones for project

### Week 6 Nov 2nd
- [X] Read code on methods of finding good 'anchors'
        Wait to hear back from Gooogle rep to download search data
- [ ] Clone repository files to my project repository
- [ ] Collecting the Google Trends data for the anchor terms running this [script](https://github.com/statistical-lusardi/box_office_success_prediction/blob/master/preprocessing/collect_gt_data_anchors.R)

### Completed Nov 11

- [X] Moving through file by file to find out the functions of box office prediction finished preprocess_movies_data
- [X] added a note-taking folder that keeps progress of my dictated findings on each file to reference question I may have had
- [X] New objective is to move through all files by next week and have dictated notes on each one. see what functions are actually necessary.


### Week 7 Nov 9th
- [X] Prepare OSF guest count data in processed format for script to handle
- [X] Find an adequate timeframe, weeks, months, and adjust accordingly for prediction. (to match study)
- [X] Google Trends data will be collected and preprocessed. reference this [article](https://towardsdatascience.com/using-google-trends-data-to-leverage-your-predictive-model-a56635355e3d) for help

### Week 8 Now 16th
- [X] Collecting and scaling the Google Trends data for the defined search terms running this [script](https://github.com/statistical-lusardi/box_office_success_prediction/blob/master/preprocessing/collect_gt_data_search_terms.R)
- [X] Met with Manuel Schmitz, the author of the google searches program and found that there were quite a few things I did not need to include in my project.
  * The function for keywords can be solved by inserting related searches found on google adwords. 
  * Subtracting the median of the searches is only necessary for movies such as star wars because the search volume is already high to begin with. I do not have that issue. 
  * I do not need to run the adjustment for time on forecast date because this was made to adjust for a movie date in Germany. 
  * The anchor words are the only words that are necessary to scale the zeros out of the relative search activity.
- [X] New focus, need to adjust the time frame for a search during a certain week thenn work with monthly searches and then seasonal searches.



- [ ] Substracting the median of the time series running this [script](https://github.com/statistical-lusardi/box_office_success_prediction/blob/master/preprocessing/preprocess_gt_data.R)

### Week 9 Nov 23rd
- [ ] Evaluate models look for over and underfitting see this [script](https://github.com/statistical-lusardi/box_office_success_prediction/blob/master/preprocessing/calculate_google_values.R) for help
- [ ] Make sure that all folders can be fully portable and functional eg results in results folder etc

### Week 10 Now 30th
- [ ] Present findings