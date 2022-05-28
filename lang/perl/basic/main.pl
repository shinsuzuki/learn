#!/usr/bin/perl
#perl -c test.pl　コマンドラインからスクリプトの文法チェック
#perl -d test.pl　コマンドラインからデバッガ起動

use strict;	#文法チェックを厳しくします
use warnings;	#傾向を有効にします

#複数行コメント
=pod
複数行の
コメントが記述できます
=cut

#お約束
print "Hello World!!\n";

#スカラ変数、変数名は英数字とアンダーバーが使用可能
my $num=1;
print "${num}\n";

#perlの数値は64ビット倍精度浮動小数点で表現、整数でも内部的には浮動小数点
my $fudou_num = 123.45;
print "${fudou_num}\n";

#文字列、''(シングルクォート)か""（ダブルクォート）で文字を囲みます
my $alp1 = 'abc';
print $alp1."\n";

#ダブルクォートの場合は変数展開が行われます
my $alp2 = "${alp1}def";
print $alp2."\n";

#シングルクォートの中で使用できない文字は直前に\をつけます
print 'cat\'s'."\n";
print '\\100'."\n";

#ダブルクォートの中で使用できない文字は直前に\をつけます
print "台詞 \"ああ\"\n";

#[\][$][@]の場合は誤って解釈されないように直前に\をつけます
print "aaa\\bbb\n";
print "aaa\$bbb\n";
print "aaa\@bbb\n";

#配列変数
my @nums=(1,2,3);

#perlでは一つのものを表現する場合は$を使用します
print "$nums[0]\n";
print "$nums[1]\n";
print "$nums[2]\n";

#配列の個数を取得
my $count = @nums;
print "$count\n";

#配列の操作
print "\n";
print "---------------- array\n";
my @animals = ("dog", "cat", "bird");

#shift
print "-- array shift\n";
print "@animals\n";
my $first = shift(@animals);
print "$first\n";
print "@animals\n";

#unshift
print "-- array unshift\n";
print "@animals\n";
unshift(@animals, "mouse");
print "@animals\n";

#pop
print "-- array pop\n";
print "@animals\n";
my $pop_animal = pop(@animals);
print "$pop_animal\n";
print "@animals\n";

#push
print "-- array push\n";
print "@animals\n";
push(@animals,"horse");
print "@animals\n";

#unshiftとpushは配列の追加にも対応
print "-- array push array\n";
my @nums1 = (1,2,3);
my @nums2 = (4,5,6);
push (@nums1,@nums2);
print "@nums1\n";

#splice
print "-- array splice\n";
my @nums3 = (1,2,3,4,5);
my @nums3_splice = splice(@nums3,1,3);
print "@nums3_splice\n";

#sort
print "-- array soft\n";
my @nums4 = (2,1,5,4,9,6,10,20);
print "@nums4\n";
my @num4_sort = sort{$a <=> $b} @nums4;
print "@num4_sort\n";

my @num4_reverse_sort = sort{$b <=> $a} @nums4;
print "@num4_reverse_sort\n";

my @nums4_string_sort = sort {$a cmp $b} @nums4;
print "@nums4_string_sort\n";

my @nums4_string_reverse_sort = sort {$b cmp $a} @nums4;
print "@nums4_string_reverse_sort\n";

#ハッシュ変数
print "\n";
print "---------------- hash\n";
my %score = ("a" => 100,"b" => 200,"c" => 300 );
print $score{"a"}."\n";
print $score{"c"}."\n";

#ハッシュのキーの存在確認
if(exists($score{"a"})){
	print "key-aは存在します\n";
}

#ハッシュのキーの削除
delete ($score{"a"});

if(!exists($score{"a"})){
	print "key-aは存在しません\n";
}

#数値演算、文字列操作
print "\n";
print "---------------- calc,string\n";
my $add = 1 + 1;
print "$add\n";
my $sub = 2 - 1;
print "$sub\n";
my $multi = 3 * 2;
print "$multi\n";
my $div = 10 / 4;
print "$div\n";
print int($div)."\n";
my $mod = 10 % 4;
print $mod."\n";

#インクリメント、デクリメント
my $i=1;
$i++;
print "$i\n";
$i--;
print "$i\n";

#文字列結合
my $str = "a"."b"."\n";
print $str;

#join
my $str_join = join("-","a","b","c");
print $str_join."\n";

my @str_array = ("a","b","c");
my $str_join2 = join("-",@str_array);
print $str_join2."\n";

#文字列分割
my @array_split = split(/\./,"aa.bb.cc.dd");
print "@{array_split}\n";

#文字列の長さ
print length("ABCDEFG")."\n";

#文字列の検索
print index("ABCDEFG","DEF")."\n";

#文字列の切り出し
print substr("abcdefg",1,2)."\n";
print substr("abcdefg",2)."\n";

#条件分岐
print "\n";
print "---------------- 条件分岐\n";
my $check = 2;
if($check == 0){
	print "check=0\n";
}elsif ($check == 1){
	print "check=1\n";
}else{
	print "check=(0 or 1) other\n";
}

#数値比較演算子
=pod
==：等しい
!=：等しくない
< ：より小さい
<=：以下
> ：より大きい
>=：以上
=cut

#文字列比較演算子
=pod
eq：等しい
ne：等しくない
lt：より小さい
le：以下
gt：より大きい
ge：以上
=cut

#論理演算子
=pod
&&：論理和
||：論理積
! ：否定
=cut

#unless
my $unless_value = 1;
unless($unless_value != 1){
	print "unless_value != 1 \n";
}

#繰り返し
print "\n";
print "---------------- 繰り返し\n";

#while
print "-- while\n";
my $i_while = 0;
while($i_while <= 3){
	print "$i_while\n";
	$i_while++;
}

print "-- for\n";
for(my $i=0;$i<3;$i++){
	print "$i\n";
}

print "-- foreach\n";
my @foreach_array = ("a","b","c");
foreach my $i(@foreach_array){
	print "$i\n";
}

#ループ制御演算子
=pod
next：次のループへ移動
last：ループを抜け出す
=cut

#繰り返しとハッシュ
#while,eachを使用
my %ids = ("Ken" => 1, "Taro" => 2, "Miki" => 3);
while(my($key,$val) = each(%ids)){
	print "key=$key,val=$val\n";
}

#foreach,keysを使用
foreach my $key (sort keys(%ids)){
	print "$key - $ids{$key}.\n";
}

#サブルーチン
print "\n";
print "---------------- サブルーチン\n";
sub _add{
	my ($num1,$num2) = @_;
	return $num1 + $num2;
}

print _add(1,3)."\n";

#正規表現
print "\n";
print "---------------- 正規表現\n";

#パターンマッチ
print "-- パターンマッチ\n";
my $str_seiki = "abcdefgabcdefg";
if($str_seiki =~ m/^ab/){
	print "先頭にabがあります\n";
}

#マッチした文字列を取得する、取り出したい文字列を"()"で囲みます、マッチした場合は順に$1,$2へ代入されます
my $str_matchstr = "ID-10-1001";
if($str_matchstr =~ m/ID-(\d{2})-(\d{4})/){
	print $1."-".$2."\n";
}

#文字列の置換
print "-- 文字列の置換\n";

#マッチした最初の文字列を置換する
my $str_replace = "abcabc";
$str_replace =~ s/a/z/;
print "$str_replace\n";

#マッチした文字列をすべて置換する
my $str_replace2 = "abcabc";
$str_replace2 =~ s/a/z/g;
print "$str_replace2\n";

#良く使う正規表現
#正規表現文字列
=pod
.(ドット)：改行を除く全ての文字列
\d：数字
\D：数字以外の文字列
\w：ワード文字列（[a-z][A-Z][0-9][_]）
\W：ワード文字列以外の文字列
\b：ワード文字の境界
\s：空白文字列（スペース「 」、タブ文字列「\t」、改行文字列「\n」）
\S：空白文字列以外の文字列
^：文字列の先頭
$：文字列の末尾
=cut

#量指定子
=pod
+：1回以上のくり返し
*：0回以上のくり返し
?：0回あるいは1回
{n}：n回
{n,m}：n回以上m回以下
=cut

#文字列クラス、複数の文字をの集合を表現する
my $str_strclass = "akb";
if($str_strclass =~ m/^[abc].*/){
	#先頭が[a],[b],[c]のどれかで始まる文字列
	print "match:先頭が[a],[b],[c]のどれかで始まる文字列\n";
}

#文字範囲指定
my $str_hanni = "AKB";
if($str_hanni =~ m/^[a-zA-Z].*/){
	#先頭が[a-zA-Z]で始まる文字列
	print "match:先頭が[a-zA-Z]で始まる文字列\n";
}

#指定した文字列以外の文字
my $str_igai = "123abc";
if($str_igai =~ m/^[^a-zA-Z]/){
	print "match:先頭が[^a-zA-Z]以外の文字列\n";	
}else{
	print "no match:先頭が[^a-zA-Z]以外の文字列\n";	
}

#複数の文字列を表す正規表現
my $str_fukusu = "abc123def456";
if($str_fukusu =~ m/(abc|def)/){
	print "match:(abc|def)文字列\n";
}else{
	print "no match:(abc|def)文字列\n";
}

#正規表現文字のエスケープ
=pod
.（ドット）：エスケープ
/（スラッシュ）：エスケープ
=cut

#正規表現オプション（複数のオプションを組み合わせることが可能）
=pod
g：パターンマッチを繰り返す
i：大文字と小文字を区別しないでマッチ
e：置換に式を利用する
s：「.（ドット）」を改行にマッチさせる
m：「^」と「$」を行の先頭と末尾にマッチさせる、この場合に文字列の先頭は「\A」末尾は「\z」を使用する
=cut

#ファイルの入出力
print "\n";
print "---------------- ファイルの入出力\n";

#ファイルの読み込み
my $rfh;
my $file="input.txt";
open($rfh, "<", $file) or die "can not open $file; $!\n";
while(my $line = <$rfh>){
	print "$line";
}
close($rfh);

#open関数
=pod
open(ファイルハンドル, オープンモード, ファイル名)
【オープンモード】　
<：読み込みモード、ファイルを読み込むときにしようします
>：書き込みモード、ファイルに書き込むときに使用します
>>:追加書き込みモード、ファイルの末尾に書き込む時に使用します
=cut

#ファイルへの書き込む
my $wfh;
my $outputfile="output.txt";
open($wfh, ">", $outputfile) or die "can not open $outputfile; $!\n";
print ($wfh "test1\n");
print ($wfh "test2\n");
close($wfh);
__END__