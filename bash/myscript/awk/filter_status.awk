BEGIN {
    print ">> start"
}
{
    if( $9 ~ /404/ ) {
        print $4 " " $5 " " $1 "(" $9 ")"
        count++
    }
}
END {
    print "<< end"
    print "count:" count
}