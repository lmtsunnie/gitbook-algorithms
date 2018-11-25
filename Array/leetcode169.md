---
title: LeetCode169 Majority Element
date: 2018-08-25 17:30:07
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- algorithms
cover: http://qiniu.limengting.site/code2.jpg
---

![](http://qiniu.limengting.site/code3.jpg)

> Given an array of size n, find the majority element.
> The majority element is the element that appears more than ⌊ n/2 ⌋ times.
> You may assume that the array is non-empty and the majority element always exist in the array.

<!-- more -->

> Example 1:
> Input: [3,2,3]
> Output: 3
> Example 2:
> Input: [2,2,1,1,1,2,2]
> Output: 2

```java
package array;

import java.util.HashMap;

public class leetcode169MajorityElement {
 /*=====================================================================================*/
    /* 自想1：
     * 时间复杂度O(n)，空间复杂度O(n)
     * 对于每一个数出现的次数用一个map存储，key为数，value为该数出现的次数
     * 由于一定存在且仅有一个majority number，所以只要某一个num出现的次数大于n/2它就是majority number
     * */
    public static int majorityElement1(int[] nums) {
        HashMap<Integer, Integer> map = new HashMap<>();
        int max = 0;
        for (int num : nums) {
            /*if (map.get(num) == null) {
            *   map.put(num, 0);
            * }
            * */
            map.putIfAbsent(num, 0);
            if (map.get(num) != null) {
                map.replace(num, map.get(num) + 1);
            }

            if (map.get(num) > nums.length / 2) {
                max = num;
            }
        }
        return max;
    }
    /*=====================================================================================*/
    /*Solution区看到的：divide and conquer
     * 时间复杂度O(nlogn)，空间复杂度O(logn)，额外空间复杂度用来记录logn个切分点
     * 时间复杂度master公式，T(N)=2T(N/2)+2N a=2,b=2,d=1 logb(a)=d时间复杂度O(NlogN)
     * 左右分治找到出现次数最多的元素，
     * 如果左右最多的元素是同一个则向上层返回这个结果，
     * 如果不是同一个则分别再数两者出现的次数，返回出现次数多的那个元素作为整体的majority number返回上一个
     * */
    public static int majorityElement2(int[] nums) {
        return majorityElement2Part(nums, 0, nums.length - 1);
    }

    //数num在nums[lo]-nums[hi]中共出现了多少次
    public static int majorityElement2Count(int[] nums, int num, int lo, int hi) {
        int count = 0;
        for (int i = lo; i <= hi; i++) {
            if (nums[i] == num) count++;
        }
        return count;
    }

    public static int majorityElement2Part(int[] nums, int lo, int hi) {
        if (lo == hi) return nums[lo];
        int mid = (lo + hi) / 2;
        int left = majorityElement2Part(nums, lo, mid);
        int right = majorityElement2Part(nums, mid + 1, hi);
        if (left == right) return left;
        return majorityElement2Count(nums, left, lo, mid) > majorityElement2Count(nums, right, mid + 1,hi)
                ? left : right;
    }
    /*=====================================================================================*/
    /*评论区最简方法：Boyer-Moore Majority Vote Algorithm
            是个online的算法，随时停止能随时出结果
            时间复杂度O(n)，空间复杂度O(1)
            遍历一遍，用m记录第一个候选者的票数，初始为1，如果下一个是这个候选者那就m++，如果不是则m--
            当m=0时清空这个候选人的信息，用m记录数组中的下一个候选人
            无论在哪里停止，m所对应的候选人就是票数超过半数的那个majority number
         */
    public static int majorityElement3(int[] nums) {
        int candidate = nums[0], m = 0;
        for (int i = 0; i < nums.length; i++) {
            if (m == 0) {
                candidate = nums[i];
            }

            if (nums[i] == candidate) {
                m++;
            } else {
                m--;
            }
        }
        return candidate;
    }
    /*=====================================================================================*/
    public static void main(String[] args) {
        int[] nums1 = new int[]{3,2,3};
        int[] nums2 = new int[]{2,2,1,1,1,2,2};

        System.out.println(majorityElement1(nums1));
        System.out.println(majorityElement2(nums1));
        System.out.println(majorityElement3(nums1));

        System.out.println(majorityElement1(nums2));
        System.out.println(majorityElement2(nums2));
        System.out.println(majorityElement3(nums2));
    }
}
```