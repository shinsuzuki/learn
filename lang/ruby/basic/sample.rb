#----------------------------------------------------------------------------- sample.rb
# -*- coding: utf-8 -*-

=begin
--------------------------------------------------------------------------------
 sample.rb - ruby.1.92
--------------------------------------------------------------------------------
=end

p Time.now.strftime("%Y/%m/%d:%H:%M:%S")
#------------------------------------------------------------------------------- 文字列
#文字列結合
puts()

#文字列を整数に変換
puts("999".to_i()) 

#文字列を少数に変換
puts("99.9".to_f())

#大文字小文字に合わせる
p "abCdefG".upcase()
p "abCdefG".downcase()

#部分文字列を取得
puts "abcdefg"[0..2]
puts "abcdefg".slice(0,3)

#文字列の先頭と末尾の空白を削除
puts "  aaabbb  ".strip()

#指定したパターンにマッチする部分を置換
puts "Apple Banana Apple Orange".sub("Apple", "Pine")
puts "Apple Banana Apple Orange".gsub("Apple", "Pine")

#任意の文字列の位置を求める
puts "Apple Banana Apple Orange".index("Banana").to_s
puts "Apple Banana Apple Orange".rindex("Apple").to_s

#含まれているかを確認
p "ABCDEFG".include?("EFG")
p "ABCDEFG".include?("XYZ")

#末端の改行を削除
s = "HelloWorld\r\n"
p s
p s.chomp()

#マッチする複数のデータを取得
datas = "abc123abc456abc789".scan(/\d{3}/);
puts(datas);




#------------------------------------------------------------------------------- 制御文
puts("--------------------> 制御文")

#if
puts("----> if");
if_a_v =2;

if if_a_v == 1
  puts("if_a_v == 1")
elsif if_a_v == 2
  puts("if_a_v == 2")
end

#case
puts("----> case");
case if_a_v
when 1
  puts("if_a_v==1");
when 2
  puts("if_a_v==2");
end 

#for
puts("----> for");
for i in 5.times
  puts(i);
end

#while
puts("----> while");
count=0;
while count < 5
  puts(count);
  count+=1;
end

#Array.each
puts("----> Array.each");
datas = [11,22,33,44,55];  
datas.each do |data|
  puts(data);
end


#times
puts("----> times");
5.times() do |i|
  puts(i);
end




#------------------------------------------------------------------------------- 基本
puts("--------------------> 基本")

#文字列長
puts("----> 文字列長(length)")
p "あいうえおavc".length()

#イテレータ
puts "イテレータ"
(1..10).each do |i|
  puts i.to_s
end

#配列
puts("----> 配列")
array = ["aaa","bbb","ccc"]
array.each do |a|
  puts a
end

#each_with_index
puts("----> each_with_index")
array.each_with_index do |item, index|
  p [index, item]  
end

#結合
puts("----> 結合")
puts array.join("+")

#配列同士の結合
puts("----> 配列同士の結合")
pa1 = [1,2,3,4]
pa2 = [4,5,6]
p pa1.concat(pa2)

#配列の和、積をとる
puts("----> 配列の和、積")
pa1 = [1,2,3,4]
p pa1 | pa2
p pa1 & pa2

#末尾に追加  
puts("----> 末尾に追加")
str_arr = []
str_arr.push("data1");  
str_arr.push("data2");
str_arr.push("data3");
puts(str_arr.join(","));
  
#サイズ
puts("----> 配列のサイズ")
puts(str_arr.length());

#末尾を取り出す
puts("----> 末尾を取り出す")
str_arr.pop();
puts(str_arr.join(","));
  
#先頭に追加
puts("----> 先頭に追加")
str_arr.unshift("data4");
puts(str_arr.join(","));
  
#先頭を取り出す
puts("----> 先頭を取り出す")
str_arr.shift();
puts(str_arr.join(","));
  
#ユニーク  
puts("----> ユニーク")
a = [1,2,3,4,5,1,2];
p a.uniq!()

#一致する要素を削除
puts("----> 一致する要素を削除")
a.delete(1)
p a

#map
puts("----> map");
p array.map{|d| "DATA_" + d}

#select
puts("----> select");
array2 = [1,2,3,4,5]
p array2.select{|d| d >=3}
  
#delete  
puts("----> delete");
array2 = [1,2,3,4,5]
p array2.delete_if{|d| d >=3}
  
#配列を探す
puts("----> 配列を探す");
array2 = [1,2,3,4,5]
p array2.index(3)
p array2.index(9)
    
#配列の各要素にブロックを実行し配列を作成
puts("----> 配列の各要素にブロックを実行し配列を作成");
a = [1,2,3,4,5,6,7]
b = [1,2,3,4,5,6,7]
p a.collect!{|x| x*10}
p a
p b.collect{|x| x*10}
p b
  
#分割
puts("----> 分割")
p "1,2,3,4,5".split(",")  
p "1\t2\t3\t4\t5".split("\t")
p "1+-+2+-+3+-+4+-+5".split("+-+")

#ハッシュ
puts("----> ハッシュ")
hash = Hash.new
hash["a"] = 1;
hash["b"] = 2;
hash["c"] = 3;
  
#値取得
puts(hash["a"]);

#キーチェック
puts (hash.has_key?("a"));

#削除
hash.delete("a");

#キーリスト
puts("キーリスト")
puts(hash.keys());

#値リスト
puts("値リスト")
puts(hash.values());

#キーと値リスト
puts("キーと値リスト")
hash.each{|key,value|
  puts("#{key} - #{value}")
}
   
#メソッド
puts("メソッド")

def t_func1(x)
  puts("<#{x}>")
end
p t_func1(2)

def t_func2(x, y)
  return x+y
end  

p t_func2(1,2).to_s

 


#------------------------------------------------------------------------------- 集合
puts("--------------------> 集合")
require 'set'
fruits1 = Set["apple", "banana", "lemon"]
p fruits1
    
#追加
fruits1.add("melon")
p fruits1

fruits2 = Set["suica", "banana", "mikan"]

#和集合
puts("和集合")  
p fruits1 | fruits2
  
#積集合
puts("積集合")  
p fruits1 & fruits2

#差集合
puts("差集合")  
p fruits1 - fruits2




#------------------------------------------------------------------------------- 出力
puts("--------------------> 出力")

#---- 出力フォーマット
puts("----> 出力フォーマット");
val1 = 1
str1= "baka"
puts "#{val1} - #{str1}"

#---- 出力フォーマット
printf("%8d\t%s",10,"aoi");
  
#---- パーセント記法
puts ("----> パーセント記法")
puts %q[あめんぼ["amenbo"]]




#------------------------------------------------------------------------------- 正規表現
puts("--------------------> 正規表現")
str="rubytest";
r= Regexp.new("^ruby");
if r =~ str
  puts("match");
elsif 
  puts("no match");
end

#マッチする複数のデータを取得
datas = "abc123abc456abc789".scan(/\d{3}/);
puts(datas);




#------------------------------------------------------------------------------- 例外
puts("--------------------> 例外")
begin
  # 実行する処理
  dest = open("backup/passwd", "w")
rescue
  # 例外が発生したときの処理
  puts("例外が発生したときの処理")
else
  # 例外が発生しなかったときに実行される処理
  puts("例外が発生しなかったときに実行される処理")
ensure
  # 例外の発生有無に関わらず最後に必ず実行する処理
  puts("例外の発生有無に関わらず最後に必ず実行する処理")
end




#------------------------------------------------------------------------------- sort
puts("--------------------> sort")

#単純なソート
puts("----> simple sort");
arr_datas = []
arr_datas.push("2")
arr_datas.push("1")
arr_datas.push("3")
p arr_datas.sort{|x,y| x.to_i <=> y.to_i}

#タブ区切りの値にてソート
puts("----> tab sort");
arr_datas=[]
arr_datas.push("a\t3");
arr_datas.push("c\t1");
arr_datas.push("d\t2");
arr_datas.push("b\t4");
puts(arr_datas.sort{|a,b| a.split("\t")[1] <=> b.split("\t")[1]});
  
#タブ区切りの値にてソート（リバース）
puts("----> reverse");  
puts(arr_datas.sort{|a,b| a.split("\t")[1] <=> b.split("\t")[1]}.reverse());

#ハッシュソート
puts("----> hash sort");
hash = {};
hash["a"] = 2;
hash["c"] = 1;
hash["b"] = 3;

#hash キーでソート
hash.sort{|a,b| a[0] <=>b [0]}.each{|a1,b1| puts("#{a1} - #{b1}")};
  
#hash  値でソート
hash.sort{|a,b| a[1] <=> b[1]}.each{|name,value| puts("#{name} - #{value}")};

    
  

#------------------------------------------------------------------------------- file
puts("--------------------> file")
require 'my_module'
include FileUtilty

#ファイルの読込書き込み
puts("----> ファイルの読込書き込み")
data_lines = []
data_lines = read_file("test_utf8.txt","r:UTF-8")
write_file("save_test.txt","w:UTF-8",data_lines)

#ディレクトリ内の指定拡張子ファイルリストを取得
puts("----> ディレクトリ内の指定拡張子ファイルリストを取得")
files = get_filenames(".\\", '.txt')

files.each do |f|
  puts(f)
end 


#------------------------------------------------------------------------------- class
puts("--------------------> class")
=begin

- file:hello_count.rb -
# -*- coding: utf-8 -*-

#------------------------------------------------ HelloCount class 
class HelloCount
  
  #定数
  VERSION = "1.00"
  
  #インスタンス変数
  @msg="";
  
  #クラス変数
  @@count=0
  
  
  attr_reader :msg
  #attr_writer :
  attr_accessor :count
  
  #コンストラクタ
  def initialize(msg)
    @msg = msg
  end

  
  #Hello
  def Hello()
    @@count += 1
    puts(@msg )
  end
end


#----- HelloCountKeisho class 
class HelloCountKeisho < HelloCount
  def Hello()
    puts "<"+ @msg + ">"
  end
end

=end


#クラス読込
require '.\hello_count'

#クラス定数の参照
p HelloCount::VERSION

#クラス使用
h = HelloCount.new("Hello sasaki")
h.Hello()

#クラス継承
hk = HelloCountKeisho.new("Hello sasaki")
hk.Hello()




#------------------------------------------------------------------------------- xml
puts("--------------------> xml")
=begin

- file:guitars.xml -
<guitars title="My Guitars">
   <make name="Fender">
      <model sn="123456789" year="2006" country="japan">
         <name>62 Reissue Stratocaster</name>
         <price>750.00</price>
         <color>Fiesta Red</color>
      </model>
      <model sn="112233445" year="2006" country="mexico">
         <name>60s Reverse Headstock Stratocaster</name>
         <price>699.00</price>
         <color>Olympic White</color>
      </model>
   </make>
   <make name="Squier">
      <model sn="445322344" year="2003" country="China">
         <name>Standard Stratocaster</name>
         <price>179.99</price>
         <color>Cherry Sunburst</color>
      </model>
   </make>
</guitars>

=end

require 'rexml/document'
include REXML

doc = Document.new File.new("guitars.xml")
print(doc)
puts("")
puts "-------------------------------------------"
doc.elements.each("guitars/make/model/color"){|element| puts element.text}
puts "-------------------------------------------"

#model
doc.elements.each("guitars/make") do |element|
  
  #タグ名、属性
  puts element.name  + ":"+ element.attributes["name"]
  
  #size  
  puts element.elements.size
  
  #データ
  element.elements.each("model") do |eleModel|
    puts "\t" +  eleModel.attributes["sn"]
    puts "\t" +  eleModel.attributes["year"]
    puts "\t" +  eleModel.attributes["country"]
    puts "\t" +  eleModel.elements["name"].text
    puts "\t" +  eleModel.elements["price"].text
    puts "\t" +  eleModel.elements["color"].text
    puts ""
  end
end