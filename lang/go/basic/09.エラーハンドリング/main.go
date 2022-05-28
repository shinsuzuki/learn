package main

import (
	"errors"
	"fmt"
	"os"
)

func main() {
	// 戻り値によるエラーハンドリング
	checkErrorFunc() // open lesson.txt: The system cannot find the file specified.

	// 自作のエラー
	checkMyErrorFunc() // myError!

	// panic
	checkPanic()
	/*
		recover
		do something
	*/

}

// 戻り値によるエラーハンドリング
func checkErrorFunc() {
	var file, err = os.Open("lesson.txt")

	if err != nil { // errorの場合はnilが返ってくる

		fmt.Println(err)
		//os.Exit(1)
		return
	}

	defer file.Close()
}

// 自作のエラー
func checkMyErrorFunc() {
	if _, err := errorAction(); err != nil {
		fmt.Println(err)
		//os.Exit(1)
		return
	}
}

func errorAction() (int, error) {
	// 戻り値は適当､末尾でエラーを返す
	return 0, errors.New("myError!")
}

// panic
func checkPanic() {
	defer func() {
		if err := recover(); err != nil {
			fmt.Println("recover")
			fmt.Println("do something")
		}
	}()

	panic("myPanic!")
}
