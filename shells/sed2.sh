#!/bin/bash

echo -e "sed 's/test/trial/' data4.txt"
sed 's/test/trial/' data4.txt

echo -e "\n"
echo -e "sed 's/test/trial/2' data4.txt"
sed 's/test/trial/2' data4.txt

echo -e "\n"
echo -e "sed 's/test/trial/g' data4.txt"
sed 's/test/trial/g' data4.txt

echo -e "\n"
echo -e "sed -n 's/test/trial/p' data5.txt"
sed -n 's/test/trial/p' data5.txt

echo -e "\n"
echo -e "sed 's/test/trial/w test.txt' data5.txt"
sed 's/test/trial/w test.txt' data5.txt

echo -e "\n"
echo -e "$ sed 's!/bin/bash!/bin/csh!' etc_password.txt | tail -1"
sed 's!/bin/bash!/bin/csh!' etc_password.txt | tail -1
















