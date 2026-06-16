#!/bin/bash

user=$(who | awk '{print $1}')
echo "user: $user"

if [[ -z $user ]]; then
  echo "user not found"
else
  echo "user found"
fi
