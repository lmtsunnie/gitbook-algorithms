---
title: LeetCode53 Maximum Subarray
date: 2018-09-04 14:36:33
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- algorithms
---

![](http://qiniu.limengting.site/code5.jpg)

> Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

<!-- more -->

> Example:
> Input: [-2,1,-3,4,-1,2,1,-5,4],
> Output: 6
> Explanation: [4,-1,2,1] has the largest sum = 6.
>
> Follow up:
> If you have figured out the O(n) solution,
> try coding another solution using the divide and conquer approach, which is more subtle.

> divide and conquer:
> 关于中间的怎么处理自己没想到通过是否跨越来分
> 参考https://www.geeksforgeeks.org/divide-and-conquer-maximum-sum-subarray/

```java
package array;

public class leetcode53MaximumSubarray {
  /*=====================================================================================*/

    /*
    自想1：利用昨天写的leetcode121中提到的Kadane算法
    扫描一次整个数列的所有数值，在每一个扫描点计算以该点数值为结束点的子数列的最大和（正数和）。
    该子数列由两部分组成：【以前一个位置为结束点】的最大子数列、该位置的数值。
    maxTmp = max(maxTmp + x，x) 前面一段的maxCur要是是负数，还不如不要前面那段以当前值作为起始
    max = max(maxTmp, max)
    时间复杂度O(n)，空间复杂度O(1)
     */
    public static int maximumSubarray1(int[] nums) {
        int max = Integer.MIN_VALUE;
        int maxTmp = 0;
        for (int num : nums) {
            maxTmp = Math.max(maxTmp + num, num);
            max = Math.max(max, maxTmp);
        }
        return max;
    }

    /*=====================================================================================*/
    /*divide and conquer:
      关于中间的怎么处理自己没想到通过是否跨越来分
      参考https://www.geeksforgeeks.org/divide-and-conquer-maximum-sum-subarray/
      
      求左边的maxSubLeft再求右边的maxSubRight,
      再求跨越中间点的maxSubCrossMid
      取max为三者最大值返回
      base case是左边或右边只有一个数，求一个数的maxSub必然是自己

      maxSubCrossMid分为求左边以nums[mid]结束的sub的最大值，右边以nums[mid+1]开始的sub的最大值
      相加即为所求

      T(n) = 2T(n/2) + O(n)
      master公式，d=1,a=b=2,d=logba=1
      时间复杂度O(n) = n的logba次方 * logn = nlogn

      logn切分点，每个切分点有O(1)个要保留的参数(nums入口,lo,hi...)
      空间复杂度logn
     */
    public static int maximumSubarray2(int[] nums) {
        return maximumSubarrayPart(nums, 0, nums.length - 1);
    }

    public static int maximumSubarrayPart(int[] nums, int lo, int hi) {
        if (lo == hi) return nums[lo];
        int mid = (lo + hi) / 2;
        int maxSubLeft = maximumSubarrayPart(nums, lo, mid);
        int maxSubRight = maximumSubarrayPart(nums, mid + 1, hi);

        int maxSubCrossMid = maxSubCrossMid(nums, lo, hi, mid);
        // 三者最大值
        int max = Math.max(Math.max(maxSubLeft, maxSubRight), maxSubCrossMid);
        if (max == maxSubLeft) return maxSubLeft;
        else if (max == maxSubRight) return maxSubRight;
        else return maxSubCrossMid;
    }

    // 固定一端的最大子数列问题
    private static int maxSubCrossMid(int[] nums, int lo, int hi, int mid) {
        int maxSubLeft = nums[mid], maxSubRight = nums[mid + 1];
        int tmpSubLeft = nums[mid], tmpSubRight = nums[mid + 1];
        for (int i = mid - 1; i >= 0; i --) {
            tmpSubLeft += nums[i];
            maxSubLeft = Math.max(maxSubLeft, tmpSubLeft);
        }
        for (int j = mid + 2; j < nums.length; j ++) {
            tmpSubRight += nums[j];
            maxSubRight = Math.max(maxSubRight, tmpSubRight);
        }
        return maxSubLeft + maxSubRight;
    }

    /*=====================================================================================*/

    public static void main(String[] args) {
        int[] nums1 = new int[]{-2, 1, -3, 4, -1, 2, 1, -5, 4};
        int[] nums2 = new int[]{-2,-1};
        System.out.println(maximumSubarray1(nums1));
        System.out.println(maximumSubarray1(nums2));

        System.out.println(maximumSubarray2(nums1));
        System.out.println(maximumSubarray2(nums2));
    }
}
```