package main

import "fmt"

func main() {

	// 配列を宣言
	var slice1 = []int{1, 2, 3, 4, 5}

	// スライスは配列に紐付けられる
	fmt.Println(slice1[:])   // [1 2 3 4 5]　配列全体をスライス
	fmt.Println(slice1[2:4]) // [3 4]
	fmt.Println(slice1[3:])  // [4 5]
	fmt.Println(slice1[:3])  // [1 2 3]
	fmt.Println(slice1[:])   // [1 2 3 4 5]

	// リテラルによるスライスの初期化
	var slice2 = []int{1, 2, 3, 4}
	fmt.Println(slice2) // [1 2 3 4]

	// スライスに要素を追加
	var slice3 []int
	slice3 = append(slice3, 1)
	slice3 = append(slice3, 2)
	fmt.Println(slice2) // [1 2]

	// スライスにスライスを追加
	var slice4 = []int{3, 4}
	var slice5 = append(slice3, slice4...)

	// 参照
	for i := 0; i < len(slice5); i++ {
		fmt.Println(slice5[i])
	}
	/*
		1
		2
		3
		4
	*/

	for _, v := range slice5 {
		fmt.Println(v)
	}
	/*
		1
		2
		3
		4
	*/

	// スライスの要素をコピー()
	var dist = []int{1, 2, 3, 4, 5}
	var src = []int{6, 7, 8}
	copy(dist[3:], src)
	fmt.Println(dist) // [1 2 3 6 7]

	// makeを使用しスライスを作成(長さとキャパシティを指定､キャパシティは省略可能)
	var slice6 = make([]int, 5, 5)
	fmt.Println(slice6) // [0 0 0 0 0]
}
