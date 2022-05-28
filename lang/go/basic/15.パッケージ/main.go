package main

import (
	"fmt"

	"./myutil"
	"./myutil/common"
)

func main() {
	s := []int{1, 2, 3, 4, 5, 6, 7, 8, 9}

	//
	fmt.Println(myutil.Average(s)) // 4

	// パッケージから書く
	common.Hello() // Hello

	// 先頭が大文字のためエクスポート可能

	fmt.Println(myutil.MySetting1) // mysetting1

	// 先頭が大文字のためエクスポート不可
	// fmt.Println(myutil.mySetting2)
}
