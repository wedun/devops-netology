package main

import "fmt"

func main() {
    fmt.Print("Enter a number of meters: ")
	var foot float64 = 3.28
    var input float64
    fmt.Scanf("%f", &input)

    output := input * foot

    fmt.Println("Foots: ", output)    
}