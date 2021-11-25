#!/bin/bash
while getopts I:R:G:L: flag
do
case "${flag}" in
I) input=${OPTARG};;
R) train_ratio=${OPTARG};;
G) y_column=${OPTARG};;
L) folder=${OPTARG};;
esac
done
mkdir -p  $folder
num=$(awk 'NR==1 {print}' $input | awk -v column=$y_column '{split($0,a,","); for(i=1;i<=length(a);i++){if(a[i]==column){print (i)}}}')
all=$(awk 'END{print FNR}' $input)
cmd="scale=0;$all*$train_ratio/100"
train_num=$(bc <<< $cmd)
validation_samples_num=$(($all-$train_num))
cd $folder
awk -v train_rows=$train_num 'NR<train_rows {print}' $input > $folder/train.csv
awk 'NR==1 {print}' $input > $folder/validation_samples.csv
awk -v validation_samples_rows=$train_num 'NR>=validation_samples_rows {print}' $input >> $folder/validation_samples.csv

