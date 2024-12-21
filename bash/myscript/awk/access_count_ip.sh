#!/bin/bash

awk '{ print $1 }' ../data/apache.log | sort | uniq -c | sort -rn | head -20


