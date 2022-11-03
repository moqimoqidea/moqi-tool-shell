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

echo -e "\n"
echo -e "sed '/1/,/3/d' data6.txt"
sed '/1/,/3/d' data6.txt

# 除此之外，要特别小心，因为只要sed编辑器在数据流中匹配到了开始模式，就会启用删除功能，这可能会导致意想不到的结果
# 第二个包含数字“1”的行再次触发了删除命令，因为没有找到停止模式，所以数据流中的剩余文本行全部被删除了。
echo -e "\n"
echo -e "sed '/1/,/3/d' data7.txt"
sed '/1/,/3/d' data7.txt

# 当然，如果指定的停止模式始终未在文本中出现，则会出现另一个问题
# 删除功能在匹配到开始模式的时候就启用了，但由于一直未能匹配到结束模式，因此没有关闭，最终整个数据流都被删除了。
echo -e "\n"
echo -e "sed '/3/,/5/d' data7.txt"
sed '/3/,/5/d' data7.txt




