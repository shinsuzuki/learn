package main

import "fmt"

func go_routine_1(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	// チャネルへ
	c <- sum
}

func main() {

	arr1 := []int{1, 2, 3}
	arr2 := []int{4, 5, 6}

	// intのchanelを作成
	chan1 := make(chan int)

	// goルーチン実行
	go go_routine_1(arr1, chan1)
	go go_routine_1(arr2, chan1)

	// チャネルからの通知を待つ
	res1 := <-chan1
	fmt.Println(res1)
	res2 := <-chan1
	fmt.Println(res2)

	/*
		順番は処理により変わる
		15
		6

	*/
}
