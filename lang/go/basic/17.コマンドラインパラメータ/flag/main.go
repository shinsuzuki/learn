package main

import (
	"flag"
	"fmt"
	"os"
)

func main() {

	// コマンドラインパラメータを取得
	var p1 = flag.Int("p1", 123, "id")
	var p2 = flag.String("p2", "hello world!", "word")

	flag.Parse()
	fmt.Println(*p1)
	fmt.Println(*p2)

	os.Exit(1)
}

/*
	パラメータを設定した場合
	> go run main.go -p1=999 -p2=hai
	999
	hai
	exit status 1

	パラメータ未指定の場合
	> go run main.go
	123
	hello world!
	exit status 1
*/
