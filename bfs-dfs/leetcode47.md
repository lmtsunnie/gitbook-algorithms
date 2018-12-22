---
title: LeetCode47 Permutations II
date: 2018-11-11 21:41:45
categories: 算法
tags:
- LeetCode
- Array
- Medium
- Java
- algorithms
- bfs/dfs
- backtracking
---

> Given a collection of numbers that might contain duplicates, return all possible unique permutations.
>
> Example:
>
> Input: [1,1,2]
> Output:
> [
>   [1,1,2],
>   [1,2,1],
>   [2,1,1]
> ]

```java
package backtracking;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static format.PrintDoubleArrayList.printDoubleList;

public class leetcode47Permutation2 {
    /*
            理解!used(i-1)：
            首先要明白i作为数组内序号，i是唯一的
            给出一个排好序的数组，[1,2,2]
            第一层递归            第二层递归            第三层递归
            [1]                    [1,2]                [1,2,2]
        序号:[0]                    [0,1]                [0,1,2]
            这种都是OK的，但当第二层递归i扫到的是第二个"2"，情况就不一样了
            [1]                    [1,2]                [1,2,2]
        序号:[0]                    [0,2]                [0,2,1]
            所以当i=2，第二层递归判断的时候!used(1)就变成了true，不会再继续递归下去，跳出循环
        */

    public static List<List<Integer>> permuteUnique(int[] nums) {
        if (nums == null || nums.length <= 0) {
            return null;
        }
        Arrays.sort(nums);
        List<List<Integer>> lists = new ArrayList<>();
        backtrack(lists, new ArrayList<>(), nums, new boolean[nums.length]);
        return lists;
    }

    public static void backtrack(List<List<Integer>> lists, List<Integer> tmpList, int[] nums, boolean[] used) {
        if (tmpList.size() == nums.length) {
            lists.add(new ArrayList<>(tmpList));
        } else {
            for (int i = 0; i < nums.length; i++) {
                if (used[i] || (i >= 1 && nums[i - 1] == nums[i] && !used[i - 1])) {
                    continue;
                }
                used[i] = true;
                tmpList.add(nums[i]);
                backtrack(lists, tmpList, nums, used);
                used[i] = false;
                tmpList.remove(tmpList.size() - 1);
            }
        }
    }

    public static void main(String[] args) {
        int[] nums = new int[]{1,1,2};
        printDoubleList(permuteUnique(nums));
    }
}

```

