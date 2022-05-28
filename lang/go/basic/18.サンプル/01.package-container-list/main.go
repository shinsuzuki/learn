package main

import (
	"container/list"
	"fmt"
)

func main() {

	list := list.New()
	list.PushBack("a")
	list.PushBack("b")
	list.PushBack("c")

	for e := list.Front(); e != nil; e = e.Next() {
		fmt.Println(e.Value)
	}
	/*
		a
		b
		c
	*/
}
