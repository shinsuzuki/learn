package main

import (
	"fmt"
	"sync"
	"time"
)

type Counter struct {
	v     map[string]int
	mutex sync.Mutex
}

func (c *Counter) Inc(key string) {
	// 排他
	c.mutex.Lock()
	defer c.mutex.Unlock()
	c.v[key]++
}

func (c *Counter) Value(key string) int {
	// 排他
	c.mutex.Lock()
	defer c.mutex.Unlock()
	return c.v[key]
}

func main() {
	c := Counter{v: make(map[string]int)}

	go func() {
		for i := 0; i < 10; i++ {
			c.Inc("key")
		}
	}()

	go func() {
		for i := 0; i < 10; i++ {
			c.Inc("key")
		}
	}()

	time.Sleep(100)
	fmt.Println(c, c.Value("key")) // {map[key:20] {0 0}} 20
}
