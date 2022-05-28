package main

import "fmt"

// 構造体を定義
type Vertex struct {
	x int
	y int
}

// 構造体の埋め込み処理
type Vertex3D struct {
	Vertex
	z int
}

// コンストラクタ
func NewVertex3D(x int, y int, z int) *Vertex3D {
	return &Vertex3D{Vertex{x, y}, z}
}

// レシーバー
func (v *Vertex3D) Area3D() int {
	return v.x * v.y * v.z
}

// main
func main() {
	// 初期化
	var v1 Vertex
	v1.x = 10
	v1.y = 20
	fmt.Println(v1.x) // 10
	fmt.Println(v1.y) // 20

	// 初期化(構造体リテラル)
	v2 := Vertex{x: 10, y: 20}
	fmt.Println(v2.x) // 10
	fmt.Println(v2.y) // 20

	// 初期化(ポインタを返す)
	pv := &Vertex{x: 10, y: 20}
	fmt.Println(pv.x) // 10
	fmt.Println(pv.y) // 20

	// 構造体の埋め込み
	v3d := NewVertex3D(3, 4, 5)
	fmt.Println(v3d.Area3D()) // 60
}
