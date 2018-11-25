---
title: LeetCode238 Product of Array Except Self
date: 2018-10-01 12:23:53
categories: 算法
tags:
- LeetCode
- Top 100 Liked Questions
- Array
- Easy
- Java
- algorithms
---

![](http://qiniu.limengting.site/code13.jpg)

> Given an array nums of n integers where n > 1, return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].

<!-- more-->

> Example:
> Input:  [1,2,3,4] 1,2,3,0
> Output: [24,12,8,6] 0,0,0,6
>
> Note: Please solve it without division and in O(n).
>
> Follow up:
> Could you solve it with constant space complexity?
> (The output array does not count as extra space for the purpose of space complexity analysis.)

```java
package array;

import static format.PrintArray.printArray;

public class leetcode238ProductOfArrayExceptItself {
 /*=====================================================================================*/
    /* 自想1：
     * 遍历一遍，算出所有数的积存在allProduct中
     * 再把allProduct/nums[i]放在product[i]处
     * 但是要考虑到有0的情况，一个0的时候除了这个0位置的product不为0，其他位置的product都为0
     * 两个以及以上个0的时候product全为0
     * 没有0的时候遍历两遍，有0的时候遍历三遍
     * 时间复杂度O(n)，空间复杂度O(1)
     * */

    public static int[] productOfArrayExceptItself1(int[] nums) {
        int allProduct = 1;
        int[] product = new int[nums.length];
        for (int num : nums) {
            allProduct *= num;
        }
        if (allProduct != 0) {
            for (int i = 0; i < nums.length; i++) {
                product[i] = allProduct / nums[i];
            }
        } else {
            int zero = 0; // 统计0的个数
            int firstZeroIndex = 0;
            int onlyNone = 1;
            boolean flag = false; // 是否遇到过0
            for (int i = 0; i < nums.length; i++) {
                if (nums[i] == 0) {
                    if (!flag) {
                        flag = true;
                        firstZeroIndex = i;
                    }
                    zero++;
                }
            }
            if (zero >= 2) {
                for (int i = 0; i < nums.length; i++) {
                    product[i] = 0;
                }
            } else { // zero == 1
                for (int i = 0; i < nums.length; i++) {
                    if (i == firstZeroIndex) continue;
                    onlyNone *= nums[i];
                    product[i] = 0;
                }
                product[firstZeroIndex] = onlyNone;
            }
        }
        return product;
    }
    /*=====================================================================================*/
    /*评论区：
    * 先将nums[0]-nums[i-1]乘到product[i]上
    * 再将nums[i+1]-nums[n-1]乘到product[i]上
    * 遍历两遍，时间复杂度O(n)，空间复杂度O(1)
    * */
    public static int[] productOfArrayExceptItself2(int[] nums) {
        int[] product = new int[nums.length];
        product[0] = 1;
        for (int i = 1; i < nums.length; i ++) {
            product[i] = product[i - 1] * nums[i - 1];
        }
        int right = 1;
        for (int i = nums.length - 1; i >= 1; i --) {
            right *= nums[i];
            product[i - 1] *= right;
        }
        return product;
    }

/*=====================================================================================*/
    public static void main(String[] args) {
        int[] nums1 = new int[]{1, 2, 3, 4};
        int[] nums2 = new int[]{1, 2, 3, 0};
        int[] nums3 = new int[]{1, 2, 0, 0};
        int[] nums4 = new int[]{9, 0, 2};

        printArray(nums1);
        printArray(productOfArrayExceptItself1(nums1));
        printArray(nums2);
        printArray(productOfArrayExceptItself1(nums2));
        printArray(nums3);
        printArray(productOfArrayExceptItself1(nums3));
        printArray(nums4);
        printArray(productOfArrayExceptItself1(nums4));

        System.out.println();

        printArray(nums1);
        printArray(productOfArrayExceptItself2(nums1));
        printArray(nums2);
        printArray(productOfArrayExceptItself2(nums2));
        printArray(nums3);
        printArray(productOfArrayExceptItself2(nums3));
        printArray(nums4);
        printArray(productOfArrayExceptItself2(nums4));
    }
}
```

打印函数：

```java
package format;

public class PrintArray {
    public static void printArray(int[] nums) {
        for (int i = 0; i < nums.length - 1; i ++) {
            System.out.print(nums[i] + " ");
        }
        System.out.println(nums[nums.length - 1]);
    }
}
```