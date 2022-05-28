package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
)

func main() {
	// os.Openfileを使用しファイルに書き込む
	func() {
		var fp, err = os.OpenFile("w_test_1.txt", os.O_CREATE|os.O_WRONLY, 0666)

		if err != nil {
			fmt.Println(os.Stderr, "file open error.")
			os.Exit(1)
		}

		defer func() {
			fmt.Println("write file close.")
			fp.Close()
		}()

		// for i := 0; i < 3; i++ {
		// 	fp.WriteString("add_item" + strconv.Itoa(i) + "\n")
		// }
		var l []string
		l = append(l, "item_"+strconv.Itoa(1))
		l = append(l, "item_"+strconv.Itoa(2))
		l = append(l, "item_"+strconv.Itoa(3))

		fp.WriteString(strings.Join(l, "\n"))
	}()
	/*
		item_1
		item_2
		item_3
	*/

	// ioutil.WriteFileを使用してファイルに書き込む
	func() {
		var l []string
		l = append(l, "item_1")
		l = append(l, "item_2")
		l = append(l, "item_3")

		ioutil.WriteFile("w_test_2.txt", []byte(strings.Join(l, "\n")), os.ModePerm)
	}()
	/*
		item_1
		item_2
		item_3
	*/

}
