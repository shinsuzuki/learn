package main

import (
	"fmt"
	"sync"
)

func producer(ch chan int, i int) {
	ch <- i * 2
}

func consumer(ch chan int, wg *sync.WaitGroup) {
	for i := range ch {
		func() {
			defer wg.Done()
			fmt.Println("p:", i*100)
		}()
	}
}

func main() {
	var wg sync.WaitGroup
	ch := make(chan int)

	for i := 0; i < 5; i++ {
		wg.Add(1)
		go producer(ch, i)
	}

	go consumer(ch, &wg)
	wg.Wait()
	close(ch)

	fmt.Println("exit")
	/*
		p: 0
		p: 200
		p: 400
		p: 600
		p: 800
		exit
	*/
}
