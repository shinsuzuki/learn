package main

import "fmt"

func main() {

	// 宣言と代入
	var msg1 string = "hello"

	// 宣言と代入(型省略)
	var msg2 = "hello"

	// 宣言と代入(var､型を省略)
	msg3 := "hello"

	// 複数の宣言と代入
	var (
		count = 1
		msg4  = "abc"
	)

	// 定数宣言(キャメルケース)
	const MyForm = 1

	// 定数宣言(キャメルケース)
	const (
		MinNumver      int    = 1
		MaxNumber             = 100
		WarningMessage string = "warning!"
	)

	fmt.Println(msg1, msg2, msg3, count, msg4)        // hello hello hello 1 abc
	fmt.Println(MinNumver, MaxNumber, WarningMessage) // 1 100 warning!
	fmt.Printf("%v\n", msg1)                          // hello
}
