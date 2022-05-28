package main

import (
	"flag"
	"fmt"
	"os"
)

func main() {
	flag.Parse()

	// コマンドラインパラメータを取得(配列)
	var params = flag.Args()
	fmt.Println(params)

	// コマンドラインパラメータを取得(インデックス)
	fmt.Println(flag.Arg(0))
	fmt.Println(flag.Arg(1))

	os.Exit(1)
}

/*
	> go run main.go aa bb
	[aa bb]
	aa
	bb
	exit status 1
*/
