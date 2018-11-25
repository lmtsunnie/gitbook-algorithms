---
title: LeetCode39 Combination Sum
date: 2018-10-18 12:35:18
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

![](http://qiniu.limengting.site/code21.jpg)

> Given a set of candidate numbers (candidates) (without duplicates) and a target number (target), find all unique combinations in candidates where the candidate numbers sums to target.
>
> The same repeated number may be chosen from candidates unlimited number of times.
>

<!-- more -->

> Note:
> All numbers (including target) will be positive integers.
> The solution set must not contain duplicate combinations.
>
> Example 1:
> Input: candidates = [2,3,6,7], target = 7,
> A solution set is:
> [
>   [7],
>   [2,2,3]
> ]
>
> Example 2:
> Input: candidates = [2,3,5], target = 8,
> A solution set is:
> [
>   [2,2,2,2],
>   [2,3,3],
>   [3,5]
> ]

```java
package backtracking;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static format.printDoubleArrayList.printDoubleList;

public class leetcode39CombinationSum {
/*=====================================================================================*/
    /*讨论区：
    自己没有考虑到remain<0的情况和else的使用
    经典回溯问题：
    Pick a starting point.
    while(Problem is not solved)
        For each path from the starting point.
            check if selected path is safe, if yes select it
            and make recursive call to rest of the problem
            before which undo the current move.
        End For
    If none of the move works out, return false, NO SOLUTON.
     时间复杂度O(n²)，空间复杂度O(n)
    * */
    public static List<List<Integer>> combinationSum(int[] nums, int target) {
        List<List<Integer>> list = new ArrayList<>();
        // Arrays.sort(nums); 不sort也可以，没说tmpList中的数要按大小顺序排列
        backtrack(list, new ArrayList<>(), nums, 0, target);
        return list;
    }

    public static void backtrack(List<List<Integer>> list, List<Integer> tmpList, int[] nums, int start, int remain) {
        if (remain < 0) {
            return;
        } else if (remain == 0) {
            list.add(new ArrayList<>(tmpList));
        } else { // 找到了一个符合要求的tmpList之后不会再在tmpList上添加
            for (int i = start; i < nums.length; i++) {
                tmpList.add(nums[i]);
                backtrack(list, tmpList, nums, i, remain - nums[i]);
                tmpList.remove(tmpList.size() - 1);
            }
        }
    }
    /*=====================================================================================*/
    public static void main(String[] args) {
        int[] nums1 = new int[]{2, 3, 5};
        int target1 = 8;
        printDoubleList(combinationSum(nums1, target1));
        System.out.println("====================");
        int[] nums2 = new int[]{2, 3, 6, 7};
        int target2 = 7;
        printDoubleList(combinationSum(nums2, target2));
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
        //lists2.add(tmpList); 输出4545，因为后面tmpList改变了，只能把副本装进去，不能把自己装进去
        lists2.add(new ArrayList<>(tmpList));
        printDoubleList(lists2);
    }
}
```