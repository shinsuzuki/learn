#-------------------------------------------------------------------------------
# main.pl
#-------------------------------------------------------------------------------

#!usr/bin/perl

#必須です
use strict;
use warnings;

#文字コード
use utf8;
binmode STDIN, ":utf8";
binmode STDOUT, ":utf8";

#モジュール
require "mylib.pm";

#クラス
require "person.pm";

#cpan
use File::Path;
use File::Find;
use Time::Format;

#test
print("------------------------------------------------------------ test-perl start\n");


#---------------------------------------------------------------------- 変数
#value 他のスクリプトと同じ、基本myにより定義する
print("<<value>>\n");
my $name="name";
my $_name="_name";

#文字列を変数へ
print("<<文字列を変数へ>>\n");
my $_num1="1";
$_num1= $_num1 + 0;
$_num1++;
print($_num1."\n");

#数値を文字列へ
print("<<数値を文字列へ>>\n");
my $_num2=1;
$_num2 = $_num2."0";
print($_num2."\n");

#変数と文字列の区別
print("<<変数と文字列の区別>>\n");
my $x = "index";
my $y="${x}.html";
print($y."\n");

#------------------------------------------------ 変数のデータ型
# 変数のデータ型
#スカラ		$	$value	1つの変数で1つの値を記録します。
#配列		@	@value	配列はスカラ変数のリストです。個々のスカラには、0から始まる数字のインデックスを使ってアクセスすることができます。
#ハッシュ	%	%value	ハッシュは、複数のスカラをキーと値のペアによって格納する変数です。配列とは違って順番がなく、キーを指定して個々のスカラにアクセスします。
#型グロブ	*	*glob	glob という名前を持つ変数すべてを意味します。
#------------------------------------------------
print("<<変数のデータ型>>\n");
my $bb=0;

#配列
my @list=(1,2,3,4);
print($list[2]."\n");
my $count=@list;	#配列をスカラにすると配列のサイズとなります
print($count."\n");

for( my $i=0;$i< $count-1;$i++){
	print($list[$i]."\n");
}

#ハッシュ
my %hash = (a => 1,b => 2 ,c => 3);
print($hash{"a"}."\n");


#パターンマッチ特殊変数
print("<<パターンマッチ特殊変数>>\n");
$x = 'abcdefg';
$x =~ /cd/;
print "マッチした文字の前にある文字： $`", "\n";
print "パターンマッチにマッチした文字： $&", "\n";
print "マッチした文字の後にある文字： $'", "\n";

#論理値は、0と空文字ならfalse、それ以外はtrue
print("<<論理値は、0と空文字ならfalse、それ以外はtrue>>\n");
if("a"){  print("string true"."\n"); }
if(!""){  print("string false"."\n"); }
if(1) { print("num true"."\n"); }
if(!0) { print("num false"."\n"); }

#変数の未定義
print("<<変数の未定義>>\n");
my $ccc = 10;
print($ccc."\n");
undef($ccc);
if (!defined($ccc)){ print("undef"."\n"); }

#バックコーテーション、コマンドを渡すことができる
print("<<バックコーテーション>>\n");
print(`ls -l`);

#エスケープを避ける (q/STRING/)
print("<<エスケープを避ける (q/STRING/)>>\n");
print(q/こんな'q',"\datas\a1" /);
print("\n");


#open(FH, "file.txt") || die("can not open file $!\n");
#close(FH);

#---------------------------------------------------------------------- 配列の値
print("<<配列>>\n");
my @week=('Sun','Mon','Tue','Wed','Thu','Fri','Sat');

#参照
print("<<配列参照>>\n");
print($week[0]."\n");

#配列の全値を結合する
print("<<配列の全値を結合する>>\n");
print(join(",",@week)."\n");

#配列の要素数を取得
print("<<配列の要素数を取得>>\n");
my $week_length = @week;
print($week_length."\n");

#配列の最後のインデックスを取得
print("<<配列の最後のインデックスを取得>>\n");
print($#week."\n");

#すべての配列にアクセス(for)
print("<<すべての配列にアクセス(for)>>\n");
for(my $i=0;$i < $#week ;$i++){
	print($week[$i]."\n");
}

#すべての配列にアクセス(foreach)
print("<<すべての配列にアクセス(foreach)>>\n");
foreach my $v (@week){
	print($v."\n");
}


#---------------------------------------------------------------------- ハッシュ
print("<<ハッシュ>>\n");

#ハッシュの初期化
print("<<ハッシュの初期化>>\n");
my %d_hash=(); 
$d_hash{"a"}="1";
$d_hash{"b"}="2";
$d_hash{"c"}="3";

#ハッシュの参照
print("<<ハッシュの参照>>\n");
print($d_hash{"a"}."\n");

#ハッシュキーリストを取得
print("<<ハッシュキーリストを取得>>\n");
my @key_list = sort(keys(%d_hash));
print(@key_list);
print("\n");

#ハッシュvaluesの取得
print("<<ハッシュvaluesの取得>>\n");
my @value_list= values(%d_hash);
print(@value_list);
print("\n");

#ハッシュのeach(ソートはできない)
print("<<ハッシュのeach(ソートはできない)>>\n");
while(my ($key, $value) = each(%d_hash)){
	print("key:$key - value:$value\n");
}

#ハッシュのキーチェック
print("<<ハッシュのキーチェック>>\n");
if(exists($d_hash{"a"})){
	print("値有り：".$d_hash{"a"}."\n");
}

#ハッシュの要素数をチェック
print("<<ハッシュの要素数をチェック>>\n");
my $n = keys(%d_hash);
print("ハッシュ要素数：$n\n");

#ハッシュを値でソート
print("<<ハッシュを値でソート>>\n");
my @keys = sort{
	$d_hash{$a} cmp $d_hash{$b}
	#$d_hash{$b} cmp $d_hash{$a}
} keys %d_hash;
print "@keys\n";


#---------------------------------------------------------------------- 制御文
#if (unessはいらない)
print("<<制御文 if>>\n");
my $checkIf = "ccc";
if($checkIf eq 'bbb'){
	print("checkIf eq 'ab'\n");
}elsif ($checkIf eq 'ccc'){
	print("checkIf eq 'ccc'\n");
}else{
	print("checkIf ne 'ab' && checkIf ne 'abc'\n");
}

#while(untilはらない)
print("<<制御文 while>>\n");
my $count=0;
while($count < 3){
	$count++;
	print("$count\n");
}

#for 
print("<<制御文 for>>\n");
for ( my $i = 1; $i <= 3; $i++ ){
	print($i, "\n");
}

#foreach
print("<<制御文 foreach>>\n");
my @ints = (1,2,3);
foreach my $f (@ints){
	print($f."\n");
}

#next
print("<<制御文 next>>\n");
my $ii=0;
while($ii < 3){
	if($ii == 1) {next;}
	print("$ii\n");
} continue{
	$ii++;
}

#continue
print("<<制御文 continue>>\n");
my $ii=0;
while($ii < 3){
	print("$ii\n");
} continue{
	$ii++;
}

#last
print("<<制御文 last>>\n");
my $ii=0;
while($ii < 3){
	if ($ii == 1) {last;}
	print("$ii\n");
} continue{
	$ii++;
}


#---------------------------------------------------------------------- サブルーチン
print("<<制御文 サブルーチン>>\n");
#サブルーチン作成、引数をコピーするので変更は反映されない
sub func()
{
	my ($a,$b) = @_;
	print "$a - $b\n";
}

&func("aka", "ao");


print("<<制御文 サブルーチン（引数に、スカラ、配列、ハッシュも可能）>>\n");
#引数に、スカラ、配列、ハッシュも可能
sub func2($@%)
{
	my ($val, $list, $hash) = @_;	#スカラーで引数を受け取る
	
	print("$val\n");

	print(join(":",@{$list} ));	#配列に
	print("\n");
	
	foreach my $key (sort(keys % {$hash})){	#ハッシュに
		print($hash->{$key}."\n");
	}
}

my $val2 = "aoi";
my @list2 = (10,11,12);
my %hash2 = ("a"=> 1,"b"=> 2,"c"=> 3);
&func2($val2, \@list2, \%hash2);


#戻り値に配列、ハッシュ、リファレンスを使う
print("<<制御文 サブルーチン（戻り値に配列、ハッシュ、リファレンスを使う）>>\n");

#戻り値に配列
sub func3_ret_array(){
	my @array = (1,2,3); 

	return \@array;
}

my $list = &func3_ret_array();
print(@{$list}."\n");

#戻り値にハッシュ
sub func4_ret_hash(){
	my %hash = ("a" => 1, "b" => 2);
	return \%hash;
}

my $hash = &func4_ret_hash();
print(%{$hash});
print("\n");


#---------------------------------------------------------------------- ファイル
#ファイル 読み込み
my @list = mylib::read_file("file.txt", "utf8");
print(join("\n",@list)); 
print("\n"); 

#ファイル 書き込み
print("<<ファイル 書き込み>>\n");
my @list = ("1111","2222","3333","日本語OK");
mylib::write_file("wr_utf8.txt", \@list, "utf8");
mylib::write_file("wr_euc.txt", \@list, "encoding(euc-jp)");
mylib::write_file("wr_sjis.txt", \@list, "encoding(cp932)");

#---------------------------------------------------------------------- 正規表現
print("<<正規表現>>\n");
my $str = "ABCDE_ABCXE";

if ($str =~ /b.+?e/gi){
	print "マッチした文字の前にある文字： $`", "\n";
	print "パターンマッチにマッチした文字： $&", "\n";
	print "マッチした文字の後にある文字： $'", "\n";

}

#複数マッチした結果
print("<<正規表現 複数マッチ>>\n");
my $str2 = "a11b22c33d44efg";
my @word = $str2 =~ /\d{2}/g;
print(join(":", @word)."\n");



#---------------------------------------------------------------------- リファレンス
#リファレンス 変数
print("<<リファレンス 変数>>\n");
my $word = "test";
my $ref_word = \$word;
print(${$ref_word}."\n");

#リファレンス 配列
print("<<リファレンス 配列>>\n");
my @list = (1,2,3,4);
my $ref_list = \@list;
print(@{$ref_list}[1]."\n");
print($ref_list->[1]."\n");

#リファレンス ハッシュ
print("<<リファレンス ハッシュ>>\n");
my%hash = (a=>"1", "b"=>"2");
my $ref_hash = \%hash;
print(${$ref_hash}{"a"}."\n");
print($ref_hash->{"a"}."\n");


#---------------------------------------------------------------------- 日本語
print("<<日本語>>\n");

#use utf8;
#binmode STDIN, ":utf8";
#binmode STDOUT, ":utf8";
#＊上記を先頭に記述。
print(substr("日本語のテスト", 1)."\n");
print(length("日本語の長さlength")."\n");

#open(FP,"<:utf8", $file); # UTF8のテキストを読み込む
#open(FP,"<:encoding(cp932)", $file); # cp932(shiftjis)のテキストを読み込む
#open(FP,">:encoding(euc-jp)",$file); # euc-jpのテキストを書き出す	

#日本語 utf8
print("<<日本語 utf8>>\n");
my @list = mylib::read_file("jp_utf8.txt", "utf8");
print(join("\n",@list)); 
print("\n"); 

#日本語 euc
print("<<日本語 euc>>\n");
my @list = mylib::read_file("jp_euc.txt", "encoding(euc-jp)");
print(join("\n",@list)); 
print("\n"); 

#日本語 sjis
print("<<日本語 sjis>>\n");
my @list = mylib::read_file("jp_sjis.txt", "encoding(cp932)");
print(join("\n",@list)); 
print("\n"); 


#---------------------------------------------------------------------- Class
print("<<class>>\n");
#my $obj = new Class;
#$obj->method();

my $p = new Person;
$p->name("suzuki");
$p->age(23) ;
$p->peers("aoi","akagi","sato");
print($p->name."\n");
print($p->age."\n");
print(join(",",$p->peers)."\n");
$p->exclaim();


#---------------------------------------------------------------------- 標準関数
print("<<標準関数>>\n");
#mkpath("data/data1/data2");

#abs
print (abs("-123")."\n");

#sqrt
print(sqrt(2)."\n");

#int
print(int("234.99")."\n");

#rand
print(rand(100)."\n");

#join(配列結合)
print(join("-",(1,2,3))."\n");

#length
print(length("123")."\n");

#substr-1
print(substr("１２３４５", 3)."\n");

#substr-2
print(substr("１２３４５", 0,2)."\n");

#substr-3
my $str = "１２３４５";
substr($str, 0, 2 , "８９");
print($str."\n");

#index-1
print(index("1234","2")."\n");

#index-2
print(index("1234512345","2", 4)."\n");

#rindex 末尾検索
print(rindex("1234512345",2)."\n");

#split
print( join("-", split(/,/,"1,2,3,4,5"))."\n");

#reverse
my $str = "abc";
print($str."\n");
my $revstr = reverse($str);
print($revstr."\n");

#uc
print(uc("abc")."\n");

#ucfirst
print(ucfirst("abc")."\n");

#lc
print(lc("ABC")."\n");

#lcfirst
print(lcfirst("ABC")."\n");

#spritf
# <書式指定子一覧>
#%c 数値をASCIIコードに対応する文字に変換
#%s 引数を文字列として解釈
#%d 引数を符号付整数として解釈
#%u 引数を符号なし整数として解釈
#%o 正数を8進文字列に変換
#%x 正数を16進文字列に変換(小文字表記)
#%X 正数を16進文字列に変換(大文字表記)
#%b 正数を2進文字列に変換 
#%f 引数を浮動少数点として解釈
#%e 引数を浮動小数点として解釈(指数表記(小文字)でフォーマット)
#%E 引数を浮動小数点として解釈(指数表記(大文字)でフォーマット)
#%g 引数を浮動小数点として解釈(指数表記(小文字)でフォーマット。末尾の0は削除される)
#%G 引数を浮動少数点として解釈(指数表記(大文字)でフォーマット。末尾の0は削除される)
#%p 引数に与えられた変数のメモリ上のアドレスに変換 
print(sprintf("%s %s %d","aa","bb", 5));

#chomp
my $str = "abc\n";
my $str2 = chomp($str);
print($str2);
print("\n");

#q演算子
print(q("aaa'bbb")."\n");

#quotemeta (うまくいかない)
#my $url = 'http://www.example0.jp/';
#print(quotemeta($url")) ;  # http\:\/\/www\.example0\.jp\/

#chr
#oct
#hex


#---------------------------------------------------------------------- ユーティリティ
#:
#my $dir = "./";
#opendir( my $dh, $dir ) or die ("Cannot open $dir: $!");
#	
#while(my $file = readdir($dh)){
#	print($file."\n");
#}
#closedir($dh);

#files(スクリプトのデータ)
#my $saerch_type = "./data/*.txt";
print("<<glob>>\n");
my $saerch_type = "./*.txt";
while(my $file = glob($saerch_type)){
	print "$file\n";
}

#コマンドを実行
system("ls");

if($? == -1){
	print("system-command error.\n");
}else{
	print("system-command success.\n");
}

#コマンド実効の結果を取得
my @list = `ls -al`;
print join("",@list);

#時刻(use Time::Format)
print(time_format('yyyy年mm月dd日 hh時mm分ss秒'."\n"));

#get_files
print("<<get_files_all_dir>>\n");
my @files = mylib::get_files_all_dir('.', '*.pl');
print (join("\n", @files));
print("\n");

print("<<get_files_top_dir>>\n");
my @files = mylib::get_files_top_dir('.', '*.pl');
print (join("\n", @files));
print("\n");


#---------------------------------------------------------------------- 例外
#print("<<例外>>\n");

#print("<<例外を発生させる>>\n");
#eval{ is_int('a')};

#sub is_int {
#    my $num = shift;
#    
#    # dieにより、値が正の整数でない場合に例外を発生させる
#    die "\"$num\" must be number." unless $num =~ /^\d+$/;
#}

##$@に例外メッセージが入っている
#if($@){
#	print("exception:$@\n");
#}


##モジュールで例外を発生させる
#print("<<モジュールで例外を発生させる>>\n");
#require "ExceptionTest.pm";

#eva{ YourModule::func(); };


##$@に例外メッセージが入っている
#if($@){
#	print("exception:$@\n");
#}

#---------------------------------------------------------------------- エンコード
print("<<エンコード>>\n");
#my $str = shift; # 外部からの入力(コマンドライン引数)
#print("$str\n");


print("<<for>\n");
my @line_length = (1,2,3,4,5);
for my $now_cnt (1..$#line_length) {
	print("$now_cnt\n");
}

print("\n");
print("------------------------------------------------------------ test-perl end\n");
exit;

#-------------------------------------------------------------------------------
# mylib.pm
#-------------------------------------------------------------------------------
package mylib;

#-------------------------------------------------------------------------------
use File::Find::Rule;
use File::Spec;

#-------------------------------------------------------------------------------
# job
#		:ファイル 読み込み
# in
#		:ファイル
#		:encoding(utf8,encoding(euc-jp),encoding(cp932))
# out
#		:行配列
# ex
#		:my @list = mylib::read_file("file.txt", "utf8");
#		:my @list = mylib::read_file("file.txt", "encoding(euc-jp)");
#		:my @list = mylib::read_file("file.txt", "encoding(cp932)");
#-------------------------------------------------------------------------------
sub read_file(){
	my($file, $enc) = @_;
	
	if (!open(FH, "<:$enc", $file)){
		die("error :$!");
	}
	
	my @ret_list = ();
	my @list = <FH>;
	foreach my $data_line (@list){
		chomp($data_line);
		push(@ret_list, $data_line);
	}
	close(FH);
	
	return @ret_list;
}

#-------------------------------------------------------------------------------
# job
#		:ファイル 書き込み
# in
#		:ファイル
#		:行配列のリファレンス
#		:encoding(utf8,encoding(euc-jp),encoding(cp932))
# out
#		:なし
# ex
#		:mylib::write_file("wr_utf8.txt", \@list, "utf8");
#		:mylib::write_file("wr_euc.txt", \@list, "encoding(euc-jp)");
#		:mylib::write_file("wr_sjis.txt", \@list, "encoding(cp932)");
#-------------------------------------------------------------------------------
sub write_file(){
	
	my ($file, $list, $enc) = @_;

	if (!open(WFH, ">:$enc", "$file")){
		die("error :$!");
	}

	foreach my $line (@{$list}){
		print WFH "$line\n"
	}

	close(WFH);
}


#-------------------------------------------------------------------------------
# job
#		:ディレクトリのファイルを取得（再帰）
# in
#		:ディレクトリ
#		:ファイルタイプ
# out
#		:ファイル一覧
# ex
#		::my @files = mylib::get_files_all_dir('./', '*.pl');
#-------------------------------------------------------------------------------
sub get_files_all_dir(){
	
	my ($dir, $search_file_type) = @_;
	
	my $rule = File::Find::Rule->new;
	$rule->file;
	$rule->name($search_file_type);
	my @files  = $rule->in($dir);
	
	return @files;
}

#-------------------------------------------------------------------------------
# job
#		:ディレクトリのファイルを取得(ディレクトリ直下のファイルのみ)
# in
#		:ディレクトリ
#		:ファイルタイプ
# out
#		:ファイル一覧
# exp
#		:my @files = mylib::get_files_top_dir('.', '*.pl');
#-------------------------------------------------------------------------------
sub get_files_top_dir(){
	
	my ($dir, $search_file_type) = @_;
	
	my @files = ();
	my $path = File::Spec->catfile($dir, $search_file_type);
	
	return glob($path);
}

#-------------------------------------------------------------------------------
return 1;


#-------------------------------------------------------------------------------
# person.pm
#-------------------------------------------------------------------------------

package Person;

#必須です
use strict;
use warnings;


################################################################################
#コンストラクタ
sub new {
	my $class = shift;
	my $self = {};
	$self->{NAME} = undef;
	$self->{AGE} = undef;
	$self->{PEERS} = [];
	bless ($self, $class);
	return $self;
}

################################################################################
#オブジェクトデストラクタ
sub END{
	print("END!\n");
}


################################################################################
#蔵のクラスデストラクタ
sub DESTROY{
	print("DESTROY!\n");
}


################################################################################
#属性
sub name {
	my $self = shift;
	if (@_) { $self->{NAME} = shift }
		return $self->{NAME};
}

sub age {
	my $self = shift;
	if (@_) { $self->{AGE} = shift }
		return $self->{AGE};
}

sub peers {
	my $self = shift;
	if (@_) { @{ $self->{PEERS} } = @_ }
		return @{ $self->{PEERS} };
}


################################################################################
sub exclaim{
	my $self = shift;
	my $str = sprintf ("Hi, I'm %s, age %d, working with %s", $self->{NAME}, $self->{AGE}, join(",", @{$self->{PEERS}}));
	print($str."\n");
}



################################################################################
return 1;