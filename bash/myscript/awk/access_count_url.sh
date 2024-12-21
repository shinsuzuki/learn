#!/bin/bash

awk '{ print $7 }' ../data/apache.log | sort | uniq -c | sort -rn


