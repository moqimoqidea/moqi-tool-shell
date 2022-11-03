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

# gsed: brew install gnu-sed
# mac os sed is different by linux sed.
echo -e "\n"
echo -e "echo \"Test Line 2\" | gsed  'i\Test Line 1'"
echo "Test Line 2" | gsed  'i\Test Line 1'

echo -e "\n"
echo -e "echo \"Test Line 2\" | gsed  'a\Test Line 1'"
echo "Test Line 2" | gsed  'a\Test Line 1'

echo -e "\n"
echo -e "gsed '3i\This is an inserted line.' data6.txt"
gsed '3i\This is an inserted line.' data6.txt

echo -e "\n"
echo -e "gsed '3a\This is an appended line.' data6.txt"
gsed '3a\This is an appended line.' data6.txt

echo -e "\n"
echo -e "gsed '1i\This is an inserted line.\This is another inserted line.' data6.txt"
gsed '1i\This is an inserted line.\nThis is another inserted line.' data6.txt

echo -e "\n"
echo -e "gsed '2c\This is a changed line of text.' data6.txt"
gsed '2c\This is a changed line of text.' data6.txt

echo -e "\n"
echo -e "gsed '/have 6 Infinity Stones/c\Snap! This is changed line of text.' data8.txt"
gsed '/have 6 Infinity Stones/c\Snap! This is changed line of text.' data8.txt

# 可以在修改命令中使用地址区间，但结果未必如愿
# sed编辑器会用指定的一行文本替换数据流中的两行文本，而不是逐一修改。
echo -e "\n"
echo -e "gsed '2,3c\This is a changed line of text.' data6.txt"
gsed '2,3c\This is a changed line of text.' data6.txt

echo -e "\n"
echo -e "sed 'y/123/789/' data9.txt"
sed 'y/123/789/' data9.txt

echo -e "\n"
echo -e "echo \"Test #1 of try #1.\" | sed 'y/123/678/'"
echo "Test #1 of try #1." | sed 'y/123/678/'

echo -e "\n"
echo -e "echo \"this is a test\" | sed 'p'"
echo "this is a test" | sed 'p'

echo -e "\n"
echo -e "sed -n '/3rd line/p' data6.txt"
sed -n '/3rd line/p' data6.txt

echo -e "\n"
echo -e "sed -n '2,3p' data6.txt"
sed -n '2,3p' data6.txt

# ~/Code/moqi-tool/moqi-tool-shell/shells (master ✗) gsed -n '/3/{
# p
# s/line/test/p
# }' data6.txt
# This is the 3rd line.
# This is the 3rd test.

echo -e "\n"
echo -e "sed '=' data1.txt"
sed '=' data1.txt

echo -e "\n"
echo -e "sed -n 'l' data10.txt"
sed -n 'l' data10.txt






















