#!/bin/bash
while getopts K:C:Z: flag
do
case "${flag}" in
K) number_of_workers=${OPTARG};;
C) column=${OPTARG};;
Z) folder=${OPTARG};;
esac
done
mkdir -p $folder
cd $folder
wget 'https://drive.google.com/uc?export=download&id=1EfRc2RLVdwWlXWz3nDIBEv_EvvOMd9ip' -O labelled_newscatcher_dataset.csv --no-check-certificate
chmod +rwx  labelled_newscatcher_dataset.csv
number_for_links=$(awk 'NR==1 {print}' labelled_newscatcher_dataset.csv | awk -v column_1=$column '{split($0,a,";"); for (i=1;i<=length(a);i++){if (a[i]==column_1){print i}}}')
awk -F\; -v i=$number_for_links '{print $i}' labelled_newscatcher_dataset.csv | parallel -j $number_of_workers wget -P $folder --no-check-certificate

#sh script1.sh -K 4 -C "link" -Z /home/donsk/task2/downloads -O links.txt


