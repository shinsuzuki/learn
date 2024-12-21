BEGIN {
    print ">> start"
}
{
    if( $4 ~ /20\/May\/2015/ ) {
        print $4 " " $5 " " $1 "-" $9
        count++
    }
}
END {
    print "<< end"
    print "count:" count
}