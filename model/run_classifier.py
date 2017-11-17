#!/usr/bin/env python

import sys
import sklearn

from sklearn.model_selection import cross_val_score
from sklearn.datasets import make_blobs
from sklearn.ensemble import RandomForestClassifier
from sklearn import preprocessing
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
import numpy as np

if (len(sys.argv) < 3):
	print "USAGE: FULL_DATA_FILE.TXT, RESULTS_FILE.TXT"
	sys.exit()


aFile = open(sys.argv[1],'r')
outfile = open(sys.argv[2],'w')


feature_vals = [[0. for x in range(7)] for x in range(176936)]
labeled_data = []
string_features0 = []

#print feature_vals
#as a rule, label encode labels, one hot encode features

bound_count = 0
unbound_count = 0
line_counter = 0

for line in aFile:
	line = line.strip()
	line = line.split()
	# I could prob format the file better in R for this , just takes forever
	string_features0.append(line[0])
	#print "line length " + str(len(line))
	#print "current line " + str(line_counter)
	for x in range(1,3):
		if line[x] == "NA":
			if line[3] == "B":
				bount_count +=1
			else:
				unbound_count +=1
			feature_vals[line_counter][x] = 0
		else:
			feature_vals[line_counter][x] = float(line[x])
	for x in range(4,8):
		if line[x] == "NA":
			if line[3] == "B":
				bount_count +=1
			else:
				unbound_count +=1
			feature_vals[line_counter][x-1] = 0
		else:
			feature_vals[line_counter][x-1] = float(line[x])
	labeled_data.append(line[3])
	line_counter += 1

#print feature_val
#print labeled_data

ohe_features = OneHotEncoder()
ohe_labels = OneHotEncoder()

#ohe_features = ohe_features.fit_transform(feature_vals[0]).toarray()
le = preprocessing.LabelEncoder()
le2 = preprocessing.LabelEncoder()

new_labeled_data = np.array(labeled_data)
#aX = new_labeled_data.reshape(-1, 1)
final_labels = le.fit_transform(labeled_data)
chroms = le2.fit_transform(string_features0)
aX = np.array(chroms)
X = aX.reshape(-1,1)
newchrs2 = ohe_labels.fit_transform(X).toarray()

#print newchrs2[0]

for x in range(176936):
	feature_vals[x][0] = chroms[x]
#print ohe_features
#print feature_vals
#print feature_vals
#print labeled_data

X = feature_vals
y = final_labels

rfClf = RandomForestClassifier(n_estimators = 100, random_state=0)
rfScores = cross_val_score(rfClf,X,y).mean()

print "bound count " + str(bound_count)
print "unbound count " + str(unbound_count)
print rfScores

