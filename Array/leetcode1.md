---
title: LeetCode1 Two Sum
date: 2018-09-05 14:49:29
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Easy
- Java
- algorithms
---

> Given an array of integers, return indices of the two numbers such that they add up to a specific target.
>
> You may assume that each input would have exactly one solution, and you may not use the same element twice.
>
> Example:
> Given nums = [2, 7, 11, 15], target = 9,
> Because nums[0] + nums[1] = 2 + 7 = 9,
> return [0, 1].

```java
package array;

import java.util.HashMap;
import java.util.Map;

public class leetcode1TwoSum {
    /*=====================================================================================*/

    /*
    自想1：
    一个输入有且仅有一个输出，一个元素最多只能用一次
    最简单的做法，根据每一个数再遍历一次
    时间复杂度O(n²),空间复杂度O(1)
    */
    public static int[] twoSum1(int[] nums, int target) {
        int remain;
        for (int i = 0; i < nums.length; i ++) {
            remain = target - nums[i];
            for (int j = i + 1; j < nums.length; j ++) {
                if (nums[j] == remain) {
                    return new int[]{i, j};
                }
            }
        }
        return null;
    }
    /*=====================================================================================*/

    /*
    自想2：用空间换时间
    用<K,V>存储所有的<num, index>
    只需要遍历一遍，对于每一个num算出remain，把remain作为K在map中查有没有这个<K,V>
    如果有将index返回
    时间复杂度O(n)，空间复杂度O(n)
    * */
    public static int[] twoSum2(int[] nums, int target) {
        Map<Integer, Integer> map = store(nums);
        int remain;
        for (int i = 0; i < nums.length; i ++) {
            remain = target - nums[i];
            if (map.get(remain) != null && map.get(remain) > i) {
                return new int[]{i, map.get(remain)};
            }
        }
        return null;
    }

    public static Map<Integer, Integer> store(int[] nums) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i ++) {
            map.put(nums[i], i);
        }
        return map;
    }
    /*=====================================================================================*/
    /*
    * Solution区：one-pass HashMap
    * 遍历一次，对于每一个元素，如果map中有remain的值(前面插入了)直接返回，
    * 如果没有则把这个元素的<num, index>插入map
    * 时间复杂度O(n)，空间复杂度O(n)
    * */
    public static int[] twoSum3(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        int remain;
        for (int i = 0; i < nums.length; i ++) {
            remain = target - nums[i];
            if (map.containsKey(remain)) {
                return new int[]{i, map.get(remain)};
            }
            map.put(nums[i], i);
        }
        return null;
    }

    /*=====================================================================================*/

    public static void main(String[] args) {
        int[] nums = new int[]{3,2,4};
        int[] res1 = twoSum1(nums, 6);
        int[] res2 = twoSum2(nums, 6);
        int[] res3 = twoSum2(nums, 6);
        System.out.println(res1[0] + " " + res1[1]);
        System.out.println(res2[0] + " " + res2[1]);
        System.out.println(res3[0] + " " + res3[1]);
    }
}
```

