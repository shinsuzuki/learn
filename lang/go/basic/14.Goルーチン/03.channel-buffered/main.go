package main

import "fmt"

func main() {
	// バッファ2のチャネルを作成
	ch1 := make(chan int, 2)

	// チャネルに値を設定
	ch1 <- 100
	ch1 <- 200

	// 順番に取り出す
	x := <-ch1
	fmt.Println(x) // 100
	y := <-ch1
	fmt.Println(y) // 200

	// forによる取り出す､closeする必要あり
	ch1 <- 100
	ch1 <- 200
	close(ch1)

	for c := range ch1 {
		fmt.Println(c)
	}
	/*
		100
		200
	*/
}
