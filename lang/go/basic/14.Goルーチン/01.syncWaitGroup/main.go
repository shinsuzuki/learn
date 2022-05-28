package main

import (
	"fmt"
	"sync"
	"time"
)

func func_a(s string, wg *sync.WaitGroup) {
	// 関数を抜けるときにwaitGroupを加算
	defer wg.Done()

	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}

func func_b(s string, wg *sync.WaitGroup) {
	// 関数を抜けるときにwaitGroupを加算
	defer wg.Done()

	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}

// 複数の非同期を待つ処理
func main() {
	// WaitGroup
	var wg sync.WaitGroup
	//待つ関数の数を設定
	wg.Add(2)

	// goにより並列に処理される
	go func_a("type-a", &wg)
	go func_b("type-b", &wg)

	// 非同期処理の終了を待つ
	wg.Wait()
}

/*
	type-b
	type-a
	type-a
	type-b
	type-b
	type-a
	type-a
	type-b
	type-a
	type-b
*/
