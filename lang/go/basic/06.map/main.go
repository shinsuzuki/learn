package main

import (
	"fmt"
	"sort"
)

func main() {

	// mapの宣言と定義
	var map1 = map[string]int{
		"apple":  100,
		"orange": 200,
		"banana": 300,
	}

	fmt.Println(map1) // map[apple:100 banana:300 orange:200]

	// mapを宣言､値を追加
	var map2 = map[string]int{}
	map2["add-item-1"] = 100
	map2["add-item-2"] = 200
	fmt.Println(map2) // map[add-item-1:100 add-item-2:200]

	// rangeによりmapを参照
	for key, value := range map2 {
		fmt.Println(key, value)
	}
	/*
		add-item-1 100
		add-item-2 200
	*/

	// mapのキーの存在確認
	{
		var val, isEexist = map2["add-item-1"]
		fmt.Println(val, isEexist) // 100 true
	}

	{
		var val, isEexist = map2["nothing"]
		fmt.Println(val, isEexist) // 0 false
	}

	// makeにより初期化(キャパシティは省略可能)
	var map3 = make(map[string]int, 10)
	map3["add-item-1"] = 100
	map3["add-item-2"] = 200
	fmt.Println(map3) // map[add-item-1:100 add-item-2:200]

	// mapの長さ
	fmt.Println(len(map3)) // 2

	// mapから要素を削除
	delete(map3, "add-item-1")
	fmt.Println(len(map3)) // 1

	// リテラルによるmapの初期化
	var capitals = map[string]string{
		"japan": "tokyo",
		"usa":   "dc",
		"china": "beijing",
	}

	key := make([]string, len(capitals), len(capitals))

	count := 0
	for k := range capitals { // keyによるソート
		key[count] = k
		count++
	}

	sort.Strings(key)

	for i := 0; i < len(key); i++ {

		fmt.Println(key[i], capitals[key[i]])
	}
	/*
		china beijing
		japan tokyo
		usa dc
	*/
}
