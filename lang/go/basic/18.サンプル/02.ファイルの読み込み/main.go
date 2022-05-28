package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
)

func main() {

	// ファイルの内容を一度に読み込む
	func() {
		str, err := ioutil.ReadFile("r_test.txt")

		if err != nil {
			panic(err)
		}

		fmt.Println(string(str))
	}()
	/*
		1.line1
		2.line2
		3.line3
		4.line4
	*/

	// 一行ずづ読み込みます
	func() {
		fp, err := os.Open("r_test.txt")
		if err != nil {
			panic(err)
		}

		defer func() {
			fp.Close()
		}()

		scanner := bufio.NewScanner(fp)
		for scanner.Scan() {
			e := scanner.Text()
			fmt.Println(e)
		}
	}()
	/*
		1.line1
		2.line2
		3.line3
		4.line4
	*/

}
