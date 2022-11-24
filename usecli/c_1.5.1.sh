#!/bin/bash

# 将作者平时在命令行中执行的所有命令都进行了统计，最终展示出 10 个最常用的命令，并相应列出每个命令的使用次数和所占百分比。
# 需要粘贴在命令行运行

history |
awk '{CMD[$2]++;count++;}END \
{ for (a in CMD)print CMD[a] " " \
CMD[a]/count*100 "% " a;}' |
grep -v "./" |
column -c3 -s " " -t |
sort -nr |
nl |
head -n10
