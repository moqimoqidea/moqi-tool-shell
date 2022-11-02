#!/bin/bash

echo -e "gawk '{print $1}' data2.txt"
gawk '{print $1}' data2.txt

echo -e "\n"
echo -e "gawk -F\; '{print $3}' data3.txt"
gawk -F\; '{print $3}' data3.txt

echo -e "\n"
echo -e "gawk 3: My name is Christine"
echo "My name is Rich" | gawk '{$4="Christine"; print $0}'

