#!/bin/bash

echo -e "sed 's/dog/cat/' data1.txt:"
sed 's/dog/cat/' data1.txt

echo -e "\n"
echo -e "sed 's/dog/cat/; s/brown/red/' data1.txt:"
sed 's/dog/cat/; s/brown/red/' data1.txt

echo -e "\n"
echo -e "sed -f script1.sed data1.txt:"
sed -f script1.sed data1.txt
