package main

import (
	"fmt"
	"strconv"
)

func main() {
	// ステートメント:if
	for _, v := range []int{1, 2, 3} {
		if v%2 == 0 {
			fmt.Println(strconv.Itoa(v) + ":2で割 -> 余りは=0")
		} else if v%3 == 0 {
			fmt.Println(strconv.Itoa(v) + ":3で割 -> 余りは=0")
		} else {
			fmt.Println(strconv.Itoa(v) + ":それ以外")
		}
	}
	/*
		1:それ以外
		2:2で割 -> 余りは=0
		3:3で割 -> 余りは=0
	*/

	// ステートメント:for
	for i := 0; i < 3; i++ {
		fmt.Println(i)
	}
	/*
		0
		1
		2
	*/

	// ステートメント:for(while的)
	var exitCount = 3

	for exitCount > 0 {
		fmt.Printf("exitCount: %d\n", exitCount)
		exitCount--
	}
	/*
		exitCount: 3
		exitCount: 2
		exitCount: 1
	*/

	// ステートメント:for(無限ループ)
	// for {
	// 	fmt.Println("running...")
	// }
	/*
		running...
		running...
		  :
	*/

	// ステートメント:range
	for index, value := range []int{1, 2, 3} {
		fmt.Println(strconv.Itoa(index) + "_" + strconv.Itoa(value))
	}
	/*
		0_1
		1_2
		2_3
	*/

	// ステートメント:switch
	for _, item := range []string{"mac", "win", "linux"} {
		switch item {
		case "mac":
			fmt.Println("mac")
		case "win":
			fmt.Println("windows")
		default:
			fmt.Println("other os")
		}
	}
	/*
		mac
		windows
		other os
	*/

	// ステートメント:defer(関数処理終了後､後入れ先出しの順序で実行される)
	func() {
		fmt.Println(">> srart")
		defer fmt.Println(">> defer1")
		defer fmt.Println(">> defer2")
		defer fmt.Println(">> defer3")
		fmt.Println(">> exit")
	}()
	/*
		>> srart
		>> exit
		>> defer3
		>> defer2
		>> defer1
	*/

}
