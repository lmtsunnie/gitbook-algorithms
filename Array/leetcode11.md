---
title: LeetCode11 Container With Most Water
date: 2018-11-23 21:36:31
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- algorithms
---

> Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai).
>
> n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
>
> Note: You may not slant the container and n is at least 2.

<!-- more -->

![](http://qiniu.limengting.site/leetcode11.jpg)

> The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
>
> Example:
>
> Input: [1,8,6,2,5,4,8,3,7]
> Output: 49

```java
package array;

public class leetcode11ContainerWithMostWater {

    /*=====================================================================================*/
    /*自想1：
    * 把首末点分别定为lo,hi，每次比较求出最大的maxWater
    * 时间复杂度O(n²)，空间复杂度O(1)
    * */
    public static int containMaxWater1(int[] nums) {
        if (nums == null || nums.length <= 1) {
            throw new RuntimeException("input error!");
        }
        int maxWater = 0;
        for (int lo = 0; lo < nums.length; lo++) {
            for (int hi = lo + 1; hi < nums.length; hi++) {
                int min = Math.min(nums[lo], nums[hi]);
                maxWater = min * (hi - lo) > maxWater ? min * (hi - lo) : maxWater;
            }
        }
        return maxWater;
    }
    /*=====================================================================================*/
    /*Solution区方法2：
    * lo, hi的起始值分别为0,n-1
    * 距离在缩短，只有移动短的才可能将min(nums[i],nums[j])增大，从而将maxWater增大
    * 遍历一遍，时间复杂度O(n)，空间复杂度O(1)
    * */
    public static int containMaxWater2(int[] nums) {
        int maxWater = 0, lo = 0, hi = nums.length - 1;
        while (lo < hi) {
            int min = Math.min(nums[lo],nums[hi]);
            maxWater = min * (hi - lo) > maxWater ? min * (hi - lo) : maxWater;
            if (nums[lo] <= nums[hi]) {
                lo ++;
            } else {
                hi --;
            }
        }
        return maxWater;
    }
    /*=====================================================================================*/
    public static void main(String[] args) {
        int[] nums = new int[]{1,8,6,2,5,4,8,3,7};
        System.out.println(containMaxWater1(nums));
        System.out.println(containMaxWater2(nums));
    }
}
```