package main

import (
	"demo/internal/handler"
	"log"
	"net"
)

func main() {
	listener, err := net.Listen("tcp", "0.0.0.0:8080")
	if err != nil {
		log.Fatal(err)
	}
	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Print(err)
			continue
		}
		go handler.HandleConnForTime(conn)
	}
}

