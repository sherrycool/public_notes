# Microsoft: Algorithm and Data Structures

## Module 1 Basic Algorithms

- Understand natural human behavior vs. computer program
- Understand human sorting and searching algorithms 
- Apply selection sort
- Apply linear search
-  Apply bubble sort

三个基本的算法

Selection Sort：选择排序

pseudocode：

```
for i in list:
    a = find the minimist
    b = list[i]
    swap a,b
```

```java
static void selectionSort(int[] lst) {
    // get the length
    int n = lst.length;
    for (int i = 0; i < n; i++) {
        int index = 0;
        int smallest = lst[i];
        for (int j = i; j < n; j++) {
            if (lst[j] < smallest) {
                smallest = lst[j];
                index = j;
            }
        int temp = lst[i];
        lst[i] = smallest;
        lst[index] = temp;
    }
    
    System.out.println(Arrays.toString(lst));
}
```

Linear search:

线性查找，一个个确认是不是那个值

pseudocode

```
for i in list:  # find v
   if i == v
   return
```

```java
static void linearSearch(int[] lst, int v) {
	int n = lst.length;
	for (int i = 0; i < n; i++) {
		if (lst[i] == v) {
			System.out.println("found! It is at" + i);
			return;
		}
	}
	System.out.println("the element is not in the array");
	return;
}
```

Bubble sort:

比较相邻的两个，交换

(每一轮循环可以保证最后一个数字是最大的)

pseudocode:

```
repeat until no swaps
		for i from 0 to n-2
			if i'th and i+1'th elements are out of order
				swap them
```



```java
static void bubbleSort(int[] lst) {
	int n = lst.length;
	boolean swapped;
	do 
	{
		swapped = false;
		for (int i = 0; i < n-1; i++) {
			if (lst[i] > lst[i+1]) {
				int temp = lst[i];
				lst[i] = lst[i+1];
				lst[i+1] = temp;
				swapped = true;
			}
		}
	} while (swapped == true)
	
	System.out.println(Arrays.toString(lst));
}
```

