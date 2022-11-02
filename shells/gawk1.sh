#!/bin/bash

echo -e "gawk '{print $1}' data2.txt"
gawk '{print $1}' data2.txt

echo -e "\n"
echo -e "gawk -F\; '{print $3}' data2.1.txt"
gawk -F\; '{print $3}' data2.1.txt

echo -e "\n"
echo -e "gawk 3: My name is Christine"
echo "My name is Rich" | gawk '{$4="Christine"; print $0}'

echo -e "\n"
echo -e "gawk 4: BEGIN"
gawk 'BEGIN {print "Hello World!"}'

echo -e "\n"
echo -e "gawk 5: BEGIN with print \$"
gawk 'BEGIN {print "The data3 File Contents:"} {print $0}' data3.txt

echo -e "\n"
echo -e "gawk 5: BEGIN with print \$ with END"
gawk 'BEGIN {print "The data3 File Contents:"} {print $0} END {print "End of File"}' data3.txt

echo -e "\n"
echo -e "gawk 6: -f print"
gawk -F: -f script3.gawk etc_password.txt

echo -e "\n"
echo -e "gawk 7: -f print beautiful"
gawk -F: -f script4.gawk etc_password.txt




