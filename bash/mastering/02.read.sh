#!/bin/bash

read -p "input your name:" name
echo "$name"


echo "__file read redirect"
while read line
do
    echo "$line"
done < input.txt

# echo "__file read cat"
# lines=$(cat input.txt)
# echo ${lines[2]}
# for line in
# do
#     echo "$line"
# done

echo "__array"
declare -a ps_array=()
while read line
do
    ps_array+=("$line")
done < input.txt
for((i=0;i<${#ps_array[@]};i++)); do
    echo "${ps_array[$i]}"
done
