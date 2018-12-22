---
title: LeetCode560 Subarray Sum Equals K
date: 2018-11-22 21:09:35
categories: 算法
tags:
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- algorithms
---

>Given an array of integers and an integer k, you need to find the total number of continuous subarrays whose sum equals to k.
>
>Example 1:
>
>Input: nums = [1,1,1], k = 2
>
>Output: 2
>
>Note:
>The length of the array is in range [1, 20,000].
>The range of numbers in the array is [-1000, 1000]
>and the range of the integer k is [-1e7, 1e7].

```java
package array;

import java.util.HashMap;
import java.util.Map;

public class leetcode560SubarraySumEqualsK {
 /*=====================================================================================*/
    /*自想1：
     * 两个变量i,j分别表示subarray的首尾位置，再遍历算出[i,j]之间的和
     * 时间复杂度O(n³)，不能AC，超时
     * */
    public static int numOfContinuousSubarraySumEqualsK1(int[] nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i; j < nums.length; j++) {
                int tmp = i;
                int tmpSum = 0;
                while (tmp <= j) {
                    tmpSum += nums[tmp++];
                }
                if (tmpSum == k) {
                    count++;
                }
            }
        }
        return count;
    }

    /*=====================================================================================*/
    /*自想2：
     * 用一个int[n + 1]数组，sum[0] = 0，sum[1] = nums[0]，sum[2] = nums[0] + nums[1]
     * sum[i]表示[0, i - 1]之间的和
     * [i, j]之间的和 = sum[j + 1] - sum[i]
     * 时间复杂度O(n²)，空间复杂度O(n)
     * */
    public static int numOfContinuousSubarraySumEqualsK2(int[] nums, int k) {
        int[] sum = new int[nums.length + 1];
        int count = 0;
        sum[0] = 0;
        for (int i = 1; i < sum.length; i ++) {
            sum[i] = sum[i - 1] + nums[i - 1];
        }
        for (int i = 0; i < sum.length; i ++) {
            for (int j = i; j < sum.length - 1; j ++) {
                if (sum[j + 1] - sum[i] == k) {
                    count ++;
                }
            }
        }
        return count;
    }
    /*=====================================================================================*/
    /*Solution区方法3：
    * 在方法1上改进，不直接确定i,j再加，而是只确定开头的i，每次加一个数就比较一次
    * 时间复杂度O(n²)，空间复杂度O(1)
    * */
    public static int numOfContinuousSubarraySumEqualsK3(int[] nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            int tmpSum = 0;
            for (int j = i; j < nums.length; j++) {
                tmpSum += nums[j];
                if (tmpSum == k) {
                    count++;
                }
            }
        }
        return count;
    }
    /*=====================================================================================*/
    /*Solution区方法4：
    * 用HashMap存储<k,v>，k为从头到某一个数的和，v为这个和出现的次数
    * sum为大和，sum-k为小和，k为差，只要找到sum和sum-k就可以构造出和为k的subarray
    * 时间复杂度O(n)，空间复杂度O(n)
    * */
    public static int numOfContinuousSubarraySumEqualsK4(int[] nums, int k) {
        int count = 0, sum = 0;
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, 1); // 小和为0，count也需要+1
        for (int i = 0; i < nums.length; i ++) {
            sum += nums[i];
            if (map.containsKey(sum - k)) { // sum为大和，sum-k为小和，k为差
                count += map.get(sum - k);
            }
            map.put(sum, map.getOrDefault(sum, 0) + 1);
        }
        return count;
    }

    /*=====================================================================================*/
    public static void main(String[] args) {
        int[] nums = new int[]{1, 1, 1};
        int k = 2;
        System.out.println(numOfContinuousSubarraySumEqualsK1(nums, k));
        System.out.println(numOfContinuousSubarraySumEqualsK2(nums, k));
        System.out.println(numOfContinuousSubarraySumEqualsK3(nums, k));
        System.out.println(numOfContinuousSubarraySumEqualsK4(nums, k));
    }
}

```

