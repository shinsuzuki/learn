package main

import (
	"fmt"
	"strconv"
	"strings"
	"unicode/utf8"
)

func main() {

	s := "Hello World"

	// 文字列の結合
	fmt.Println(s + "!!") //  Hello World!!

	// 大文字･小文字変換(stringsパッケージ)
	fmt.Println(strings.ToUpper(s)) // HELLO WORLD
	fmt.Println(strings.ToLower(s)) // hello world

	// 部分取得(下限値～上限値-1まで)
	fmt.Println(s[2:7]) // llo W
	// 部分取得(下限値～まで)
	fmt.Println(s[6:]) // World

	// trim
	fmt.Printf("[%v]\n", strings.TrimSpace("   abc   "))      // [abc]
	fmt.Printf("[%v]\n", strings.Trim("   abc   ", " "))      // [abc]
	fmt.Printf("[%v]\n", strings.TrimLeft("   abc   ", " "))  // [abc   ]
	fmt.Printf("[%v]\n", strings.TrimRight("   abc   ", " ")) // [   abc]

	// 含まれているかどうか?
	fmt.Println(strings.Contains(s, "Hello")) // true
	fmt.Println(strings.Contains(s, "abc"))   // false

	// 出現位置
	fmt.Println(strings.Index(s, "W"))     // 6
	fmt.Println(strings.Index(s, "Z"))     // -1
	fmt.Println(strings.LastIndex(s, "r")) // 8

	// 文字列のカウント
	fmt.Println(strings.Count(s, "World")) // 1

	// 先頭一致
	fmt.Println(strings.HasPrefix(s, "Hello")) // true

	// 末尾一致
	fmt.Println(strings.HasSuffix(s, "World")) // true

	// 文字列の置換
	var h3 = "Hello Hello Hello"
	fmt.Println(strings.Replace(h3, "Hello", "HELLO", 1)) // HELLO Hello Hello
	fmt.Println(strings.ReplaceAll(h3, "Hello", "HELLO")) // HELLO HELLO HELLO

	// 分割
	var csv = "abc,def,ghi"
	var array = strings.Split(csv, ",")
	fmt.Println(array) // [abc def ghi]

	// 配列文字を結合
	var datas = []string{"abc", "def", "ghi"}
	fmt.Println(strings.Join(datas, "-")) // abc-def-ghi

	// 文字列の長さ(len関数はバイト数)
	ja := "GO言語"
	fmt.Println(len(ja)) // 8
	// 文字列の長さ(utf8.RuneCountInStringはユニコード文字数)
	fmt.Println(utf8.RuneCountInString(ja)) // 4

	// 文字列を数値へ変換
	var ns = "123"
	var n, _ = strconv.Atoi(ns)
	fmt.Printf("type:%T - value:%v\n", n, n) // type:int - value:123
}
