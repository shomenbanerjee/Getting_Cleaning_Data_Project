# Getting_Cleaning_Data_Project
Project submission for GCD Week3

Overview:

The Coursera project required us to deliver run_analysis.R script that operates on raw data set and create a transformed TidyData.txt file. Please follow the readme and CodeBook file uploaded in this repository to know more about the TidyData and the transformation executed by run_analysis.R program.

Pre-requisite:

Following are the pre-requisites for running the run_analysis.R script on your computer.

1. You have R software installed on your computer (ver 3.1.3 & above)
2. You have installed packages: dplyr, reshape and reshape2
3. You have downloaded the following dataset and extracted the .zip file under your R working directory. (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

About run_analysis.R:

The run_analysis.R program is expected to run data transformation on the raw dataset you have in your working directory to produce a TidyData.txt file. In order to do this, the program initially checks for the existence of the dataset in the working directory. If the dataset is not found in the original format (with .zip extracted), the program would throw an error message and exit. However, if the dataset is found, it proceeds further extracting and performing transformation on the data to generate TidyData.txt file that is loaded into the 'UCI HAR Dataset' folder. More information on TidyData.txt file is available in the CodeBook.md file.
