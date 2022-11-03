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
echo -e "sed 's!/bin/bash!/bin/csh!' etc_password.txt | tail -1"
sed 's!/bin/bash!/bin/csh!' etc_password.txt | tail -1

echo -e "\n"
echo -e "sed '2s/dog/cat/' data1.txt"
sed '2s/dog/cat/' data1.txt

echo -e "\n"
echo -e "sed '2,3s/dog/cat/' data1.txt"
sed '2,3s/dog/cat/' data1.txt

echo -e "\n"
echo -e "sed '2,$s/dog/cat/' data1.txt"
sed '2,$s/dog/cat/' data1.txt

echo -e "\n"
echo -e "sed '/rich/s/bash/csh/' etc_password.txt | tail -1"
sed '/rich/s/bash/csh/' etc_password.txt | tail -1

echo -e "\n"
echo -e "sed '3d' data6.txt"
sed '3d' data6.txt

echo -e "\n"
echo -e "sed '2,3d' data6.txt"
sed '2,3d' data6.txt

echo -e "\n"
echo -e "sed '2,$d' data6.txt"
sed '2,$d' data6.txt

# https://stackoverflow.com/a/339941
echo -e "\n"
echo -e "tail -n +2 data6.txt"
tail -n +2 data6.txt













