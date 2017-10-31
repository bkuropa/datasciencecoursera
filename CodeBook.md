CODE BOOK FOR run_analysis.R

1)  importActData - importing of all necessary data from the parent folder
	- xtrain: training data on the x vector (561 features)
	- ytrain: training data on the y vector (6 activities)
	- subtrain: training data with subject ID number (1 - 30)
	- xtest: testing data x ...
	- ytest: testing data y ...
	- subtest: testing data subject ...
	- desname: x vector labels from features.txt
	- actnames: activty labels for y data from activity_labels.txt
	- sub/x/ytotal: row merge of train + test
	- totaltbl: dataframe of subject, activity (y), and x-vector combined and labeled descriptively

2) extractSTATS - filters "totaltbl" for keywords 'mean'/'std' in column names
	- mytable: dataframe to filter - i.e. totaltbl from (1)
	- tblout: filtered dataframe to return (same row #s, fewer col#s)

3) setActNames - replaces all y values with descriptive labels
	- mytable: table to be rewritten with descriptive col - i.e. totaltbl after (2)
	- nametbl: dataframe containing descriptive activity names and their corresponding number code
	- tblout: dataframe following rewriting of activities (same row/col #s)

4) meanTable - builds table of mean values sorted from 'subject'+'activity'
	- mytable: dataframe from which to average values
	- nametbl: activity (y) values for defining unique sorted activity entries
	- meantbl: table containg mean values of each column tallyed from (a) subject, then (b) activity type.  30 subjects x 6 activities = 180 rows, same col#s.
	- grpdata: subset of all entries from one subject
	- meanvect: single row of ONLY numeric averaged columns
	- frontvect: first two (i.e. non-numeric) col#s of grpdata
	- newline: concatinated frontvect + meanvect for a full row

5) cleanNames - removes punctuation and capitals from colNames (i.e. "tidy data" requirements)
	- mytable: accepted table to rewrite column names (i.e. meantbl in 4)
	- clnname: string variable of individual colname to 'clean'

6) tidyData: executes functions 1 - 5 given a file path
	- location: location of data folder (i.e. getwd(), or other) 


