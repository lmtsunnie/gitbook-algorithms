---
title: LeetCode78 Subsets
date: 2018-10-16 19:03:19
categories: 算法
tags:
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- backtracking回溯
- algorithms
---

![](http://qiniu.limengting.site/code14.jpg)

> Given a set of distinct integers, nums, return all possible subsets (the power set).
> Note: The solution set must not contain duplicate subsets.

<!-- more -->

> Example:
> Input: nums = [1,2,3]
> Output:
> [
>   [3],
>   [1],
>   [2],
>   [1,2,3],
>   [1,3],
>   [2,3],
>   [1,2],
>   []
> ]

```java
package backtracking;

import java.util.ArrayList;
import java.util.List;

import static format.printDoubleArrayList.printDoubleList;

public class leetcode78Subsets {
  /*=====================================================================================*/

    /*必然是看的讨论区的： 
    backtracking thoughts:
    Pick a starting point.
    while(Problem is not solved)
        For each path from the starting point.
            check if selected path is safe, if yes select it
            and make recursive call to rest of the problem
            before which undo the current move.
        End For
    If none of the move works out, return false, NO SOLUTON.

    用tempList存储要放入list中的单元，回溯之后注意撤回上一步
    每个数可以在或者不在tmpList中，或者说n个整数的集合的子集有2^n个，所以时间复杂度O(2^n)
    递归的深度是O(n)在每个切分点要记录一次start，也使用了辅助空间tmpList为O(n)，所以额外空间复杂度O(n)*1 + O(n) = O(n)
    输出顺序：[[],[1],[1,2],[1,2,3],[1,3],[2],[2,3],[3]]
    */

    public static List<List<Integer>> subsets(int[] nums) {
        List<List<Integer>> lists = new ArrayList<>();
        // Arrays.sort(nums);
        backtrack(lists, new ArrayList<>(), nums, 0);
        return lists;
    }

    public static void backtrack(List<List<Integer>> lists, List<Integer> tmpList, int[] nums, int start) {
        // 注意：不能lists.add(tmpList);
        // 因为tmpList后面一直在修改，我们只想把现在的副本放进lists中
        lists.add(new ArrayList<>(tmpList));
        for (int i = start; i < nums.length; i ++) {
            tmpList.add(nums[i]);
            backtrack(lists, tmpList, nums, i + 1);
            tmpList.remove(tmpList.size() - 1);
        }
    }
    /*=====================================================================================*/
    public static void main(String[] args) {
        int[] nums = new int[]{1,2,3};
        printDoubleList(subsets(nums));
    }
}
```

打印函数：

```java
package format;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class printDoubleArrayList {
    public static void printDoubleArray(int[][] arrays) {
        for (int[] array : arrays) {
            for (int i : array) {
                System.out.print(i + " ");
            }
            System.out.println();
        }
    }

    public static void printDoubleList(List<List<Integer>> lists) {
        for (List<Integer> list : lists) {
            for (Integer i : list) {
                System.out.print(i + " ");
            }
            System.out.println();
        }
    }

    public static void printDoubleArrayList(ArrayList<ArrayList<Integer>> arrayLists) {
        for (ArrayList<Integer> arrayList : arrayLists) {
            for (Integer i : arrayList) {
                System.out.print(i + " ");
            }
            System.out.println();
        }
    }

    public static void main(String[] args) {
        List<List<Integer>> lists = new ArrayList<>();
        lists.add(Arrays.asList(1,2));
        lists.add(Arrays.asList(4,5,6));
        lists.add(Arrays.asList(7,8,9,10));
        printDoubleList(lists);
        System.out.println("=======================================");

        ArrayList<ArrayList<Integer>> arrayLists = new ArrayList<>();
        arrayLists.add(new ArrayList<Integer>(Arrays.asList(1,2,3,4)));
        arrayLists.add(new ArrayList<Integer>(Arrays.asList(4,5,6)));
        arrayLists.add(new ArrayList<Integer>(Arrays.asList(7,8)));
        printDoubleArrayList(arrayLists);
        System.out.println("======================================");

        List<List<Integer>> lists2 = new ArrayList<>();
        List<Integer> tmpList = new ArrayList<>();
        tmpList.add(1);
        tmpList.add(2);
        tmpList.add(3);
        //lists2.add(tmpList);
        lists2.add(new ArrayList<>(tmpList));
        tmpList.clear();
        tmpList.add(4);
        tmpList.add(5);
        //lists2.add(tmpList); 输出4545，因为tmpList后面改变了。
        lists2.add(new ArrayList<>(tmpList));
        printDoubleList(lists2);
    }
}

```

