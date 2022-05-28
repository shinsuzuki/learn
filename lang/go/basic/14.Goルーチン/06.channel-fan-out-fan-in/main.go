package main

import (
	"fmt"
	"strconv"
)

func producer(first chan int) {
	defer close(first)

	for i := 0; i < 5; i++ {
		fmt.Println("first < " + strconv.Itoa(i))
		first <- i
	}
}

func bai2(first <-chan int, second chan<- int) {
	defer close(second)

	for v := range first {
		fmt.Println("second < " + strconv.Itoa(v))
		second <- v * 2
	}
}

func bai4(second <-chan int, third chan int) {
	defer close(third)

	for v := range second {
		fmt.Println("third < " + strconv.Itoa(v))
		third <- v * 4
	}
}

func main() {
	first := make(chan int)
	second := make(chan int)
	third := make(chan int)

	// パイプラインのパターン
	go producer(first)
	// chanで渡す
	go bai2(first, second)
	// chanで渡す
	go bai4(second, third)

	for v := range third {
		fmt.Println(v)
	}
}

/*
	0
	8
	16
	24
	32
*/
