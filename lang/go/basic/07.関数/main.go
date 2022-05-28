package main

import "fmt"

// 引数あり､戻り値なし
func outputNum(x int) {
	fmt.Println(x)
}

// 引数あり､戻り値あり
func calcNum1(x int, y int) int {
	return x + y
}

// 引数あり､戻り値(複数)あり
func calcNum2(x int, y int) (int, int) {
	return x + y, x - y
}

// 引数あり､戻り値(複数)あり
func calcNum3(x int, y int) (r1 int, r2 int) {
	r1 = x + y
	r2 = x - y

	//return r1, r2
	return
}

// 可変長パラメータ(スライスとして受け取る)
func calcNum4(x int, days ...int) {
	fmt.Println(x)

	for _, day := range days {
		fmt.Println(day)
	}
}

// 戻り値に名前をつける
func calcNum5(x int, y int) (p1 int, p2 int) {
	p1 = x * 2
	p2 = y * 3
	return
}

// クロージャー
func countNumber(baseCcount int) func(addCount int) int {
	var totalCount = baseCcount

	return func(addCount int) int {
		totalCount += addCount
		return totalCount
	}
}

func main() {
	// 引数あり､戻り値なし
	outputNum(100) // 100

	// 引数あり､戻り値あり
	var r1 = calcNum1(10, 20)
	fmt.Println(r1) // 30

	// 引数あり､戻り値(複数)あり
	var r2, r3 = calcNum2(10, 2)
	fmt.Println(r2, r3) // 12 8

	// 引数あり､戻り値(複数)あり
	var r4, r5 = calcNum3(10, 2)
	fmt.Println(r4, r5) // 12 8

	// 関数を変数に渡して実行
	var f = func(str string) {
		fmt.Println("inner fuc:" + str)
	}

	f("execute") // inner fuc:execute

	// 関数を定義し､そのまま実行
	func(str string) {
		fmt.Println("inner fuc:" + str)
	}("exceute") // inner fuc:execute

	// 可変長パラメータ
	calcNum4(100, 1, 2, 3)
	/*
		100
		1
		2
		3
	*/

	// 戻り値に名前をつける
	p1, p2 := calcNum5(1, 2)
	fmt.Println(p1)
	fmt.Println(p2)

	// クロージャー1
	var p3 = 999
	func() {
		// 関数リテラルの外部の変数にアクセス
		fmt.Println(p3)
	}()

	// クロージャー2
	var count = countNumber(100)
	fmt.Println(count(10))
	fmt.Println(count(10))

}
