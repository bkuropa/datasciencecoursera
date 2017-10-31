=================================================================
run_analysis software
=================================================================
Bryan Kuropatwa course project for Getting and Cleaning Data course with Coursera 
=================================================================
The software is split into five separate functions - each representing a different "task" within the project.  The function tidyData(location) accepts the folder pathway directing to the Samsung data offered in the course.  Afterwards, each function works in-situ with the next to process the data, producing the table of means for each column in the end.

importActData is called first, accepting the folder location and gathing the data from Training, Testing, and parent folders and moving them into R.  Test/training are all merged together, the column names are inserted from the parent folder and a "total table" of all this data is produced in the end.

extractSTATS comes next.  The function filters the above table such that columns whose names contain 'mean' or 'std' (standard deviation) remain.

This filtered table is sent to setActNames, which exchanges numeric activity codes for the words SITTING/STANDING/etc, returning the altered table afterwards.

meanTable accepts this and calculates each column's mean via colMeans (only accepting fully numeric rows) temporarily croping 'subject' and 'activity'.  The table is grouped by subject first, and activity second giving 30x6 rows of means at the end.

The final step, cleanNames, follows the requirements for tidy names and removes all punctuation and capitals for column names.  The final result is returned - avgdata.