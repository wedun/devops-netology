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