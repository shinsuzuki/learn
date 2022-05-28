package main

import (
	"fmt"
	"os"
)

func main() {
	// 標準出力
	fmt.Print("標準出力1")
	fmt.Print("\n")
	fmt.Println("標準出力2")
	fmt.Printf("%s, %d\n", "標準出力3", 999)
	/*
		標準出力1
		標準出力2
		標準出力3, 999
	*/

	// 標準エラー
	fmt.Fprint(os.Stderr, "標準エラー1")
	fmt.Print("\n")
	fmt.Fprintln(os.Stderr, "標準エラー2")
	fmt.Fprintf(os.Stderr, "%s, %d\n", "標準エラー3", 999)

	/*
		標準エラー1
		標準エラー2
		標準エラー3, 999
	*/
}
