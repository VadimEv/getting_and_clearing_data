### Course project Code book

Source data can be find in the link provided in repository description

Data provided is divided in 2 subsets: train and test, each placed in separate folder.

In each of folders there is 3 files of interest:

* X_train.txt/X_test.txt are data tables with 561 variables. Please note that X is capitalized in name of this files

* y_train.txt/y_test.txt are files containing activity IDs, number of rows corrsponding to those in X_

* subject_train.txt/subject_test.txt are respective files with subject ID.

You can find the scipt run_analysis.R in repository, and it is reccomended to source it with echo(ctrl+shift+enter in R Studio by default)

Script executes with following order:

## Part 1

* Merges X_test.txt with X_train.txt producing the 10299 rows and 561 columns 

* Merges subject_train.txt/subject_test.txt producing 10299 rows of subject IDs alone

* Merges y_test.txt/y_train.txt producing 10299 rows of activity IDs

## part 2

* Reads features.txt to name the columns in merged X set, and 

* extracts only columns with "mean" and "std" keywords, to extract only necessary columns, this results in 10299 x 66 data frame.

## part 3

* read activity labels from activity_labels.txt

* apply descriptive names instead of IDs in Y array formed in part 1

## part 4

* adds name for subject array

* Creates tidy data set merging arrays created in part 1-3

## part 5

* Creates independent tidy data set with averaged features across multiple instances for each subject and activity