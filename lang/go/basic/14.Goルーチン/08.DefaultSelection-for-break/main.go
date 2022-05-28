package main

import (
	"fmt"
	"time"
)

func main() {
	tick := time.Tick(100 * time.Millisecond)
	boom := time.After(500 * time.Millisecond)

myloop:
	for {
		select {
		case <-tick:
			fmt.Println("tick")
		case <-boom:
			fmt.Println("boom")
			break myloop
		default:
			fmt.Println("default")
			time.Sleep(50 * time.Millisecond)
		}
	}
	fmt.Println("########## exit")
}

/*
default
default
tick
default
default
tick
default
default
tick
default
default
tick
default
default
boom
########## exit
*/
