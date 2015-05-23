Mark down file
#This repo is part of the John Hopkins’ “Getting and Cleaning Data” course in the Data Scientist certification series.
##The run_analysis.R script creates two dataframe databases:  “finaldata” and “TidyData”.  It utilizes the raw data from the The Human Activity Recognition database that was collected from the accelerometers from the Samsung Galaxy S smartphone.  The raw data used is provided at:
<q> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   </q>

A description of the Information for this raw data is provided at the following site: <q>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  <q/>

##The Human Activity Recognition database was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.  The run_analysis.R scripts creates a “finaldata” database that provides a subset of this raw data only with “mean” or “std” descriptions.  The “TidyData” database summarizes the data by using the “finaldata” dataframe to find the mean of all its columns sorted by subject and activity in ascending order. 

##Information on the manipulation of the raw Human Activity Recognition data to form one combined database, the experimental design, source data, the variables used, the summary and the final databases can be found in the CodeBook file.

