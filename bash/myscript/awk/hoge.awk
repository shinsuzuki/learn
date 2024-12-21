BEGIN {
    print "start1"
}

{
    #print NR ":" $1 $2
    if (NR > 3) {
        print NR ":" $1 $2
    }
}

END {
    print "end"
}
