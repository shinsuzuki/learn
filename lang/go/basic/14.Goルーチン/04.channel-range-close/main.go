package main

import (
	"fmt"
	"time"
)

func go_routine_3(s []int, c chan int) {
	sum := 0

	for _, v := range s {
		sum += v
		time.Sleep(100 * time.Millisecond)

		// チャネルに通知
		c <- sum
	}

	// チャネルを閉じる
	close(c)
}

func main() {
	arr1 := []int{1, 2, 3, 4, 5}

	// チャネルを作成
	chan1 := make(chan int)
	//chan1 := make(chan int, len(arr1))

	// Goルーチンを実行
	go go_routine_3(arr1, chan1)

	// チャネルから値を取り出す､空になるまで処理される
	for v := range chan1 {
		fmt.Println(v)
	}
	/*
		1
		3
		6
		10
		15
	*/

}
