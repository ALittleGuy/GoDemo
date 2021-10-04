package handler

import (
	"bufio"
	"fmt"
	"io"
	"log"
	"net"
	"strings"
	"time"
)

func HandleConnForTime(c net.Conn) {
	defer func(c net.Conn) {
		err := c.Close()
		if err != nil {
			log.Fatalln(err)
		}
	}(c)
	for {
		_, err := io.WriteString(c, fmt.Sprintf("connection: %v -> %v  %v", c.RemoteAddr().String(),
			c.LocalAddr().String(), time.Now().Format("15:04:05\n")))
		if err != nil {
			return
		}
		time.Sleep(1 * time.Second)
	}
}

func HandleConnForReply(c net.Conn)  {
	defer c.Close()
	fmt.Fprintln(c,"\t" , "test")
	input  := bufio.NewScanner(c)
	for input.Scan() {
		echo(c , input.Text() , 1*time.Second)
	}
}

func echo(c net.Conn, text string, duration time.Duration) {
	fmt.Fprintln(c , "\t" , strings.ToUpper(text))
	time.Sleep(duration)
	fmt.Fprintln(c , "\t" , strings.ToUpper(text))
	time.Sleep(duration)
	fmt.Fprintln(c , "\t" , strings.ToLower(text))
}