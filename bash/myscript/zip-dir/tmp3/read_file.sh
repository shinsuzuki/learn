#!/bin/bash

input_file='news.txt'

echo '<redirect file>'
while read line 
do
  echo $line
done < ${input_file}


echo '' 
echo '<pipeline>'
cat ${input_file} | while read line
do
  echo $line
done



