---
title: LeetCode386 Lexicographical Numbers
date: 2018-11-10 16:47:04
categories: 算法
tags:
- LeetCode
- Medium
- Java
- algorithms
- bfs/dfs
- backtracking
---

![](http://qiniu.limengting.site/work20.jpg)

> Given an integer *n*, return 1 - *n* in lexicographical order.
>
> For example, given 13, return: [1,10,11,12,13,2,3,4,5,6,7,8,9].
>
> Please optimize your algorithm to use less time and space. The input size may be as large as 5,000,000.

<!-- more -->

看成9颗树，子节点是在父节点的基础上加一位（`*10 + i`），按顺序进行先序遍历。

```
	     1        2        3    ...
      /\        /\       /\
   10 ...19  20...29  30...39   ....
  /\      /\ /\  /\   /\   /\  
 100...109               390...399 ...
```

```java
package backtracking;

import java.util.ArrayList;
import java.util.List;

import static format.PrintList.printList;

public class leetcode386LexicographicalNumbers {
    public static List<Integer> lexicalOrder(int n) {
        List<Integer> list = new ArrayList<>();
        for (int i = 1; i <= 9; i ++) {
            dfs(list, n, i);
        }
        return list;
    }

    public static void dfs(List<Integer> list, int n, int cur) {
        if (cur > n) return;
        list.add(cur);
        for (int i = 0; i <= 9; i ++) {
            dfs(list, n, 10 * cur + i);
        }
    }

    public static void main(String[] args) {
        int n = 101;
        printList(lexicalOrder(n));
    }
}

```

打印函数：

```java
package format;

import java.util.ArrayList;
import java.util.List;

public class PrintList {
    public static void printList(List<Integer> list) {
        Integer[] array = list.toArray(new Integer[list.size()]);
        for (Integer i : array) {
            System.out.print(i + " ");
        }
        System.out.println();
    }

    public static void main(String[] args) {
        List<Integer> arrayList = new ArrayList<>();
        arrayList.add(1);
        arrayList.add(2);
        arrayList.add(3);
        printList(arrayList);
    }
}
```

