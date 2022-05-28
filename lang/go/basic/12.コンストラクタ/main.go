package main

import "fmt"

type Vertex struct {
	x int
	y int
}

func NewVertex(x int, y int) *Vertex {
	// ポインタを返す
	return &Vertex{x: x, y: y}
}

func main() {
	pv := NewVertex(100, 200)
	fmt.Println(*pv)
}
