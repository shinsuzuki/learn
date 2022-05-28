package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func main() {

	// コピー元､先のファイル名
	srcFile := "text_1.txt"
	distFile := "text_1.txt.bak"

	// ファイルが存在する場合は削除
	if _, err := os.Stat(srcFile); err == nil {
		fmt.Println("remove file")
		_ = os.Remove(srcFile)
	}

	if _, err := os.Stat(distFile); err == nil {
		fmt.Println("remove file")
		_ = os.Remove(distFile)
	}

	// 基本ファイルを作成
	ioutil.WriteFile(srcFile, []byte("dummy\n"), os.ModePerm)

	// ファイルをコピー
	_ = os.Link(srcFile, distFile)
}
