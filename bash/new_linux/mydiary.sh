#!/bin/bash

dfile="$(date '+%Y-m-%d').txt"

if [ ! -e "$dfile" ]; then
  date '+%Y-%m-%d' > "$dfile"
fi

vim "${dfile}"


