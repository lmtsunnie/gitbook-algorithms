---
title: LeetCode75 SortColors
date: 2018-11-23 21:11:44
categories: 算法
tags:
- LeetCode
- Top 100 Liked Questions
- Array
- Easy
- Java
- partition
- algorithms
---

>Given an array with n objects colored red, white or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white and blue.
>
>Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.
>
>Note: You are not suppose to use the library's sort function for this problem.
>
>Example:
>Input: [2,0,2,1,1,0]
>Output: [0,0,1,1,2,2]
>
>Follow up:
>A rather straight forward solution is a two-pass algorithm using counting sort.
>First, iterate the array counting number of 0's, 1's, and 2's,
>then overwrite array with total number of 0's, then 1's and followed by 2's.
>Could you come up with a one-pass algorithm using only constant space?

```java
package array;

import static format.PrintArray.printArray;

public class leetcode75SortColors {  
    /*=====================================================================================*/
    /*自想：荷兰国旗问题
     * partition过程看成向小于区域和大于区域发货
     * 时间复杂度O(n),空间复杂度O(1)
     * */
    public static void sortColors(int[] nums) {
        if (nums == null || nums.length <= 1) return;
        partition(nums, 0, nums.length - 1);
    }

    public static void partition(int[] nums, int lo, int hi) {
        int less = -1;
        int more = nums.length;
        int cur = 0;
        while (cur < more) {
            if (nums[cur] == 0) {
                swap(nums, cur++, ++less);
            } else if (nums[cur] == 1) {
                cur++;
            } else if (nums[cur] == 2) {
                swap(nums, cur, --more);
            }
        }
    }

    public static void swap(int[] nums, int lo, int hi) {
        if (lo == hi) return;
        nums[lo] = nums[lo] ^ nums[hi];
        nums[hi] = nums[lo] ^ nums[hi];
        nums[lo] = nums[lo] ^ nums[hi];
    }

    /*=====================================================================================*/
    public static void main(String[] args) {
        int[] nums = new int[]{2,0,2,1,1,0};
        printArray(nums);
        sortColors(nums);
        printArray(nums);
    }
}

```

