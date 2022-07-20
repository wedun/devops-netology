Задача 1. Установите golang.
```
>choco install golang -y

>go version
go version go1.18.4 windows/amd64
```

Задача 3. Написание кода.
Напишите программу для перевода метров в футы  
```go
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
```

Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:  
```go
package main

import "fmt"
func BubbleSort(array[] int)[]int {
	for i := 0; i < len(array)-1; i++ {
		for j := 0; j < len(array)-i-1; j++{
			if (array[j] > array[j+1]) {
				array[j], array[j+1] = array[j+1], array[j]
			}
		}
	}
	return array
}

func main() {
	x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
	var y = BubbleSort(x)
	fmt.Println(y[0])
}
```

Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …).
```go
package main
import "fmt"

func main() {
  	for i := 1; i <= 100; i++ {
		if (i % 3) == 0 {
			fmt.Print(i, "\n")
		}
	}
}
```