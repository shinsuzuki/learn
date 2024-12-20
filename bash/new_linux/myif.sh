#!/bin/bash

if [[ "$1" = "bin" ]]; then
  echo "ok"
else
  echo "ng"
fi


if grep 'bash' /etc/passwd; then
  echo 'bash founc'
fi

exit 1
