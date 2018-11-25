---
title: LeetCode90 Subsets II
date: 2018-10-18 14:06:29
categories: 算法
tags:
- LeetCode
- Array
- Medium
- Java
- backtracking回溯
- algorithms
---

![](http://qiniu.limengting.site/code22.jpg)

> Given a collection of integers that might contain duplicates, nums, return all possible subsets (the power set).

<!-- more -->

> Note: The solution set must not contain duplicate subsets.
> Example:
> Input: [1,2,2]
> Output:
> [
>   [2],
>   [1],
>   [1,2,2],
>   [2,2],
>   [1,2],
>   []
> ]

```java
package backtracking;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static backtracking.leetcode78Subsets.subsets;
import static format.printDoubleArrayList.printDoubleList;

public class leetcode90Subsets2 {  
    /*=====================================================================================*/
    /*比leetcode78 Subsets多了一个条件：给定的nums可能有重复元素
    * 基本回溯能实现，skip duplicates边界条件扣的不清楚看的讨论区的
    * */
    public static List<List<Integer>> subsets2(int[] nums) {
        List<List<Integer>> list = new ArrayList<>();
        Arrays.sort(nums);
        backtrack(list, new ArrayList<>(), nums, 0);
        return list;
    }

    public static void backtrack(List<List<Integer>> list, List<Integer> tmpList, int[] nums, int start) {
        list.add(new ArrayList<>(tmpList));
        for (int i = start; i < nums.length; i ++) {
            // i-1的时候都已经算过一遍了，且要求i和i-1都在[start,n-1]范围内
            if (i > start && nums[i] == nums[i - 1]) {
                continue; // skip duplicates
            }
            tmpList.add(nums[i]);
            backtrack(list, tmpList, nums, i + 1);
            tmpList.remove(tmpList.size() - 1);
        }
    }

    public static void main(String[] args) {
        int[] nums = new int[]{1,2,2,4};
        printDoubleList(subsets2(nums));
        System.out.println("=======================");
        printDoubleList(subsets(nums));
        System.out.println("=======================");
        int[] nums2 = new int[]{1,2,3,4};
        printDoubleList(subsets(nums2));
    }
}
```