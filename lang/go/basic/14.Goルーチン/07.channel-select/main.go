package main

import (
	"fmt"
	"time"
)

func go_routine_a(ch chan string) {
	for {
		ch <- "message from [a]"
		time.Sleep(100)
	}
}

func go_routine_b(ch chan string) {
	for {
		ch <- "message from [b]"
		time.Sleep(100)
	}
}

func main() {
	// チャネルを作成
	ch1 := make(chan string)
	ch2 := make(chan string)

	// Goルーチンを実行
	go go_routine_a(ch1)
	go go_routine_b(ch2)

	// 別々に通知を受け取り
	for {
		select {
		case msg1 := <-ch1:
			fmt.Println(msg1)
		case msg2 := <-ch2:
			fmt.Println(msg2)
		}
	}
}

/*
	message from [b]
	message from [a]
	message from [a]
	message from [b]
	message from [b]
		:
*/
