# Speech Recognition (Digits from 0-9)

Speech recognition application to recognize spoken digits from 0 to 9.

I provide a .mat file that contains trained data, training it with Matlab machine learning toolbox (Classification Learner) using different algorithms, featuring k-nearest neighbors or bagged trees.

File 'digit_recognition.m' contains a program that takes input audio files (recorded spoken digits) located in the same directory and classifies them. The output is a cell array that contains the name of the file in the first column and the classification (from 0-9) result.

The methods used in the process and the extracted features from the data are described in detail in the provided file 'report.pdf'.

Our algorithm showed an accuracy of 74% for such classification.
