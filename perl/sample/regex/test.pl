# 正規表現の書き方
my $infile="sample.txt";

open(FILE, $infile) or die "$!";
while(<FILE>) {
    if(/^[a-z]/) {
        print("alphabet ok:".$_)
    } else {
        print("alphabet ng:".$_)
    }
}

close(FILE);

# - sample.txt -
# 1234
# abcdefg
# xyz
# 5789


# > perl test.pl
# alphabet ng:1234
# alphabet ok:abcdefg
# alphabet ok:xyz
# alphabet ng:5789

