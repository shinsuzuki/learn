#!/bin/bash

# bash -x ./debug_how.sh
echo ">> start"

item1=""
item2="def"
echo "$item1"
echo "$item2"

if [[ $item1 ]]; then
    echo '$item1 is not empty.'
else
    echo '$item1 is empty.'

fi

echo "<< end"


