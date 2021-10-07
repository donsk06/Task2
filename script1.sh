#!/bin/bash
chmod +rwx labelled_newscatcher_dataset.csv
touch links.txt
awk -F\; '{print $2}' labelled_newscatcher_dataset.csv > links.txt
mkdir finals
wget -i links.txt -P /home/donsk/finals --no-check-certificate

