package main

import "fmt"

type SelfIntroduction interface {
	Say() string
}

type Hero struct {
	Name string
}

type Enemy struct {
	Name string
}

func (h Hero) Say() string {
	return "my nam is " + h.Name + "(hero)"
}

func (e Enemy) Say() string {
	return "my name is " + e.Name + "(enemy)"
}

func Hello(s SelfIntroduction) string {
	return s.Say()
}

func main() {
	hero := Hero{"mario"}
	enemy := Enemy{"kuppa"}

	fmt.Println(Hello(hero))  // my nam is mario(hero)
	fmt.Println(Hello(enemy)) // my nam is kuppa(enemy)
}
