---
title: LeetCode35 Search Insertion Position
date: 2018-09-04 20:34:58
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Easy
- Java
- algorithms
---

![](http://qiniu.limengting.site/code6.jpg)

> Given a sorted array and a target value, return the index if the target is found.
> If not, return the index where it would be if it were inserted in order.
> You may assume no duplicates in the array.

<!-- more -->

> Example 1:
> Input: [1,3,5,6], 5
> Output: 2
>
> Example 2:
> Input: [1,3,5,6], 2
> Output: 1
>
> Example 3:
> Input: [1,3,5,6], 7
> Output: 4
>
> Example 4:
> Input: [1,3,5,6], 0
> Output: 0

```java
package array;

public class leetcode35SearchInsertionPosition {
    /*=====================================================================================*/

    /*
      自想1：二分查找递归版
      注意到数组是有序的，且没有重复元素，想到用二分查找
      时间复杂度O(logn)，空间复杂度O(1)
    */
    public static int searchInsertionPosition1(int[] nums, int target) {
        return binarySearch(nums, 0, nums.length - 1, target);
    }

    public static int binarySearch(int[] nums, int lo, int hi, int target) {
        // 只剩一个数，如果大于它则插在它后面，返回它的坐标+1
        // 等于它返回它的坐标，小于它代替它的位置也是返回它的坐标
        if (lo == hi) {
            /*if (target < nums[lo]) {
                return lo;
            } else if (target > nums[lo]) {
                return lo + 1;
            } else return lo;*/
            if (target > nums[lo]) return lo + 1;
            else return lo;
        }
        int mid = lo + (hi - lo) / 2;
        // target在前半段
        if (target < nums[mid]) {
            return binarySearch(nums, lo, mid, target);
        }
        // target在后半段
        if (target > nums[mid]) {
            return binarySearch(nums, mid + 1, hi, target);
        }
        else return mid;
    }

    /*=====================================================================================*/

    /*
    讨论区：二分搜索迭代版
    * */
    public static int searchInsertionPosition2(int[] nums, int target) {
        int lo = 0, hi = nums.length - 1;
        int mid;
        while (lo != hi) {
            mid = (lo + hi) / 2;
            // target在前半段
            if (target < nums[mid]) {
                hi = mid;
            // target在后半段
            } else if (target > nums[mid]) {
                lo = mid + 1;
            } else return mid;
        }
        return target > nums[lo] ? lo + 1 : lo;
    }

    /*=====================================================================================*/

    public static void main(String[] args) {
        int[] nums = new int[]{1,3,5,6};
        System.out.println(searchInsertionPosition1(nums, 5));
        System.out.println(searchInsertionPosition1(nums, 2));
        System.out.println(searchInsertionPosition1(nums, 7));
        System.out.println(searchInsertionPosition1(nums, 0));

        System.out.println(searchInsertionPosition2(nums, 5));
        System.out.println(searchInsertionPosition2(nums, 2));
        System.out.println(searchInsertionPosition2(nums, 7));
        System.out.println(searchInsertionPosition2(nums, 0));
    }
}
```