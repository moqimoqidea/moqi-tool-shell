#!/bin/bash

echo -e "gawk '{print $1}' data2.txt"
gawk '{print $1}' data2.txt

echo -e "\n"
echo -e "gawk -F\; '{print $3}' data3.txt"
gawk -F\; '{print $3}' data3.txt

