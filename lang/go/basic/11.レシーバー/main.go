package main

import "fmt"

type Vertex struct {
	x int
	y int
}

func (v Vertex) Bai(num int) (x int, y int) {
	x = v.x * num
	y = v.y * num
	return
}

func (v *Vertex) Update(x int, y int) {
	v.x = x
	v.y = y
}

func main() {
	// Bai
	v1 := Vertex{x: 10, y: 20}
	var x, y = v1.Bai(3)
	fmt.Println(x) // 30
	fmt.Println(y) // 60

	// Update
	v1.Update(100, 200)
	fmt.Println(v1.x) // 100
	fmt.Println(v1.y) // 200

}
