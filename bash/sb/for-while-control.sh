#!/bin/bash

# == for
for item in 1 2 3 ; do
  echo "item: $item"
done

for f in *.sh; do
  echo "file: $f"
done

# == while
while read line; do
  echo "line: $line"
done < access.log

cat access.log | while read line; do
  echo "line: $line"
done


