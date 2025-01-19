#!/bin/bash

select item in red blue green
do
  case $item in 
    red)   echo "select red"; break ;;
    blue)  echo "select blue"; break ;;
    green) echo "selec green"; break ;;
    *) echo "select failure, item:${item}"; break ;;
  esac
done
