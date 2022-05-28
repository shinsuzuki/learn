package main

import (
	"fmt"
	"path/filepath"
)

func main() {
	// target
	path := "c:\\f1\\f2\\hoge.txt"

	// パスからディレクトリ部分を取得
	dir := filepath.Dir(path)
	fmt.Println(dir)
	/*
		c:\f1\f2
	*/

	// パスからファイル名を取得
	fileName := filepath.Base(path)
	fmt.Println(fileName)
	/*
		hoge.txt
	*/

	// パスからディレクトリとファイル名を同時に取得
	d, f := filepath.Split(path)
	fmt.Println("dir  => " + d)
	fmt.Println("file => " + f)
	/*
		dir  => c:\f1\f2\
		file => hoge.txt
	*/

	// パスから拡張子を取得
	extension := filepath.Ext(path)
	fmt.Println(extension)
	/*
		.txt
	*/
}
