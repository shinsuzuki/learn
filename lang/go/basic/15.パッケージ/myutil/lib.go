package myutil

// 先頭が大文字なのでエクスポート可能
const MySetting1 string = "mysetting1"

// 先頭が小文字なのでエクスポート不可
const mySetting2 string = "mysetting2"

func Average(s []int) int {
	total := 0

	for v := range s {
		total += v
	}

	return int(total / len(s))
}
