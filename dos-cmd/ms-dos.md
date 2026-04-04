
# MS-DOS Learn

## ファイルを作成、開く、名前変更、コピー、削除する方法
- ファイルを作成
  - copy con file1.txt
  - echo hello world > hello.txt
- ファイル内容を確認
  - type file1.txt
- ファイルをリネーム
  - ren file1.txt file2.txt 
- ファイルをコピー
  - copy file2.txt cmc2.txt
- ファイルを削除
  - del file2.txt
  - type cmc2.txt
  - del cmc2.txt

## DIRを作成、変更、削除する
- DIRを作成
  - mkdir [dirname]
- DIRを削除
  - rmdir [dirname] ※中身画からであること
- DIRをを削除(中身を含めて削除、確認なし)
  - rmdir /s /q [dirname] 
- DIRをリネーム
  - ren [old_dirname] [new_dirname]
- 階層のDIRを作成
  - mkdir a\b\c
- 複数のDIRを作成(スペースを開ける)
  - mkdir a b c
- DIRの構造を確認
  - tree /f
   
## ファイルとフォルダーをコピー
  -  ファイルをコピー
     -  copy file1.txt file2.txt
  -  ワイルドカードでまとめてコピー
     -  copy *.txt /tmp_dir
  -  DIRをコピー
     -  xcopy a_dir b_dir /s /e
        -  /s:中身のあるDIRをコピー
        -  /e:空のサブDIRをコピー
     -  大量のデータをDIRコピー
        -  robocopy source_dir destination_dir /e /z /mt:8

## ファイルの移動
 - ファイルを移動
   - move file1.txt a_dir
   - move *.txt a_dir
   - move file1.txt a_dir/new_file1.txt
 - フォルダの移動
   - move \y a_dir b_dir

## DIRコマンド
  - フィアル名とディレクトリ名を表示
    - dir /b
  - ファイル名のみ表示(サブフォルダの中身まで)
    - dir /b /s /a-d 
  - DIR名のみ表示(サブフォルダの中身まで)
    - dir /b /s /ad  
  - 並び替え("-"を入れると逆になります。/od なら /o-d で新しい順)
    - 名前
      - dir /on
    - サイズ(小さい順)
      - dir /os
    - 日付順(古い,一番下に最新が表示される)
      - dir /od
    - グループ順
      - dir /og

## 日付
  - 日付を確認する
    - date
  - 時刻を確認する
    - time

## 階層構造を表示する
  - DIRのツリー構造を表示
    - tree
  - DIRのツリー構造を表示(ファイルを含める)
    - tree /f
  - ファイルに出力
    - tree /f /a > tree-info.txt

## 属性の設定
  - attrib コマンド
    - +: 属性を設定
    - -: 属性を解除
    - h: 隠しファイル
    - s: システムファイル
    - r: 読み取り専用
  - ファイルを読み取り専用にする
    - attrib +h hello.txt
  - 現在の属性を確認する
    - attrib hello.txt

## 色を変える(画面毎)
  - color [背景色][文字色]
    - コード,色,コード,色
    0,黒 (Black),8,灰色 (Gray)
    1,青 (Blue),9,明るい青 (Light Blue)
    2,緑 (Green),A,明るい緑 (Light Green)
    3,水色 (Aqua),B,明るい水色 (Light Aqua)
    4,赤 (Red),C,明るい赤 (Light Red)
    5,紫 (Purple),D,明るい紫 (Light Purple)
    6,黄色 (Yellow),E,明るい黄色 (Light Yellow)
    7,白 (White),F,明るい白 (Bright White)

## 並び替え
  - sort [対象ファイル]
    - option
      - /r: 逆順
      - /+n: N番目の文字を基準に並び替え
 
## ファイルの比較
  - fc /n [file1] [file2]

## 検索
  - find /n "error" log.txt

##  エクスプローラを開く
  - start .