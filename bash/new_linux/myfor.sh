#!/bin/bash


for i in $(seq 1 3)
do
  echo "seq:$i"
done


for p in $@
do
  echo "$p"
done
