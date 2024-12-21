BEGIN {
    print ">> start"
}

($3 ~ /^TRACE/) {    ## 改行すると動かない
    printf("%-12s %s\n",$3,$4)
    count++
}

END {
    print "<< end"
    print "count:" count
}