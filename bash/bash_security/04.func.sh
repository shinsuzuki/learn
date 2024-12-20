#!/bin/bash

function myfunc_1() {
    echo "exe myfunc_1"
}

function myfunc_2() {
    echo "exe myfunc_2 $1 $2"
}

myfunc_1
myfunc_2 "echo > 引数値A" "引数値B"
