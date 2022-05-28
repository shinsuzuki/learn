package main

import "fmt"

func main() {

	// 宣言と定義を別々に行う
	var arr1 [2]int
	arr1[0] = 100     // 配列要素へのアクセス
	arr1[1] = 200     // 配列要素へのアクセス
	fmt.Println(arr1) // [100 200]

	// 宣言と定義を同時に行う(個数指定あり)
	var arr2 = [2]int{1, 2}
	fmt.Println(arr2) // [1 2]

	// 宣言と定義を同時に行う(個数指定なし)
	var arr3 = [...]int{1, 2, 3, 4}
	fmt.Println(arr3) // [1 2 3 4]

	// インデックスを利用して値を取り出す
	for i := 0; i < len(arr3); i++ {
		fmt.Println(arr3[i])
	}
	/*
		1
		2
		3
		4
	*/

	// rangeを使用して値を取り出す､1つ目はインデックス､2つ目が要素の値
	// インデックスが不要の場合はブランク識別子(_)へ代入
	for i, m := range arr3 {
		fmt.Printf("index:%v - value:%v\n", i, m)
	}
	/*
		index:0 - value:1
		index:1 - value:2
		index:2 - value:3
		index:3 - value:4
	*/

	// 配列の長さを取得
	arr4 := [...]int{1, 2, 3}
	fmt.Println(len(arr4)) // 3
}
