#!/bin/bash

ps -aux | awk '{ print $6, $11 }' | sort -k 1 -n -r
