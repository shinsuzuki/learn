package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
)

func main() {

	// clear
	if _, err := os.Stat("hoge"); err == nil {
		fmt.Println("remove dir")
		os.Remove("hoge")
	}

	if _, err := os.Stat("hoge1"); err == nil {
		fmt.Println("remove dir")
		os.RemoveAll("hoge1")
	}

	// ディレクトリを作成
	if err := os.Mkdir("hoge", 0777); err != nil {
		panic(err)
	}

	// ディレクトリ､サブディレクトリを作成
	if err := os.MkdirAll("hoge1/hoge2", 0777); err != nil {
		panic(err)
	}

	// ディレクトリ内の一覧を取得
	files, err := ioutil.ReadDir("./")
	if err != nil {
		panic(err)
	}

	for _, file := range files {
		path, _ := filepath.Abs(file.Name())
		fmt.Println(path)
	}
}
