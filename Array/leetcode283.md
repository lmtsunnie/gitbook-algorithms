---
title: LeetCode283 Move Zeroes  
date: 2018-08-25 14:47:58
categories: 算法
tags:
- LeetCode
- Top 100 Liked Questions
- Array
- Easy
- Java
- algorithms
cover: http://qiniu.limengting.site/code1.jpg
---

![](http://qiniu.limengting.site/code2.jpg)

> Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

<!-- more -->

> Example:
>
> Input: [0,1,0,3,12]
> Output: [1,3,12,0,0]
>
> Note:
>
> You must do this in-place without making a copy of the array.
> Minimize the total number of operations.

```java
package array;

public class leetcode283MoveZeros {
    /*=====================================================================================*/
    /*
    自想1：时间复杂度O(n)，空间复杂度O(1)
    从左到右用i遍历原数组，用j记录该放到哪个位置，
    初始i=0,j=0,遇到不为0的就放到j位置，j++，i遍历完成后，j后面的全补0
    */
    public static void moveZeros(int[] nums) {
        if (nums == null || nums.length == 0) return;
        int insertIndex = 0;
        for (int num : nums) {
            if (num != 0) {
                nums[insertIndex ++] = num;
            }
        }
        while (insertIndex < nums.length) {
            nums[insertIndex ++] = 0;
        }
    }
    /*=====================================================================================*/
    // 打印函数
    public static void printArray(int[] nums) {
        for (int i = 0; i < nums.length - 1; i ++) {
            System.out.print(nums[i] + " ");
        }
        System.out.println(nums[nums.length - 1]);
    }

    public static void main(String[] args){
        int[] nums = {0,1,0,3,12};
        printArray(nums);
        moveZeros(nums);
        printArray(nums);
    }
}
```