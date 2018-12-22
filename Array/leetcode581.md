---
title: LeetCode581 Shortest Unsorted Continuous Subarray
date: 2018-09-06 00:30:51
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- algorithms
---

> Given an integer array, you need to find one continuous subarray that if you only sort this subarray in ascending order, then the whole array will be sorted in ascending order, too.
>
> You need to find the shortest such subarray and output its length.
>
> Example 1:
> Input: [2, 6, 4, 8, 10, 9, 15]
> Output: 5
> Explanation:
> You need to sort [6, 4, 8, 10, 9] in ascending order to make the whole array sorted in ascending order.
>
> Note:
> Then length of the input array is in range [1, 10,000].
> The input array may contain duplicates, so ascending order here means <=.

> 后三种解答参考https://leetcode.com/problems/shortest-unsorted-continuous-subarray/solution/

```java
package array;

import java.util.Arrays;
import java.util.Stack;

public class leetcode581ShortestUnsortedContinuousSubarray {
    /*=====================================================================================*/
    /*
     自想1：
     和已经排序的数列进行对比，遍历两遍找出lo,hi
     Solution区看到的改进，遍历一遍即可
     时间复杂度O(n)+O(nlogn)+O(n)=O(nlogn)
     空间复杂度O(n)
    * */
    public static int shortestSubarray1(int[] nums) {
        int[] copy = nums.clone();
        Arrays.sort(nums);
        int lo = Integer.MAX_VALUE, hi = Integer.MIN_VALUE;
        /*for (int i = 0; i < nums.length; i ++) {
            if (copy[i] != nums[i]) {
                lo = i;
                break;
            }
        }
        for (int j = nums.length - 1; j >= 0; j --) {
            if (copy[j] != nums[j]) {
                hi = j;
                break;
            }
        }*/
        for (int i = 0; i < nums.length; i++) {
            if (copy[i] != nums[i]) {
                lo = Math.min(i, lo);
                hi = Math.max(i, hi);
            }
        }
        return lo > hi ? 0 : hi - lo + 1;
    }

 /*=====================================================================================*/

    /*
    Solution区看到的：
    找到第一个不在正确位置上的数lo和最后一个不在正确位置上的数hi
    不在正确位置上的数是指我作为nums[i]或nums[j]有nums[i] > nums[j]且i < j
    lo是其中最小的num[i]，hi是其中最大的nums[j]
    lo和hi组合起来就是所求
    时间复杂度O(n²)，空间复杂度O(1)
    这个答案提交会超时，无法AC
    */
    public static int shortestSubarray2(int[] nums) {
        int lo = Integer.MAX_VALUE, hi = Integer.MIN_VALUE;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[i] > nums[j]) {
                    lo = Math.min(i, lo);
                    hi = Math.max(j, hi);
                }
            }
        }
        return lo > hi ? 0 : hi - lo + 1;
    }
    /*=====================================================================================*/
    /*
     * 用栈来模仿插入排序的过程
     * 从前往后遍历数组，如果是上升的就正常压入栈中，
     * 如果是下降的就把栈中的数倒出来倒到合适的位置（>=栈顶）再将这个数压入栈中，记录这个数插入的位置，
     * 再继续遍历剩下的数组寻找下一个下降的数，得到的插入的位置中最小的就是lo
     * 注意倒出的数并没有再倒回数组中，因为最终有用的是lo所以插入到lo前面来的数才需要记录，倒出的是后面的数，不需要管
     * 同理反向遍历在下降的中找上升的数的插入的位置，得到的最大的位置就是hi
     * 时间复杂度O(n)，空间复杂度O(n)
     * */
    public static int shortestSubarray3(int[] nums) {
        int lo = Integer.MAX_VALUE, hi = Integer.MIN_VALUE;
        Stack<Integer> stack = new Stack<>();
        for (int i = 0; i < nums.length; i++) {
            /*
            正常都是上升的，刚刚压入的数（栈顶）<= 即将压入的数（nums[i]）
            当栈顶大于即将压入的数则不能正常压入，
            要将栈中的元素倒出来一部分直到栈顶 <= 即将压入的数 或者 倒到栈为空，此时才可以压入这个数
            */
            while (!stack.isEmpty() && nums[stack.peek()] > nums[i]) {
                lo = Math.min(lo, stack.pop());
            }
            stack.push(i);
        }
        stack.clear();
        // 逆着看
        for (int j = nums.length - 1; j >= 0; j--) {
            while (!stack.isEmpty() && nums[stack.peek()] < nums[j]) {
                hi = Math.max(hi, stack.pop());
            }
            stack.push(j);
        }
        return lo > hi ? 0 : hi - lo + 1;
    }
    /*=====================================================================================*/
    /*Solution区：
    参考https://leetcode.com/problems/shortest-unsorted-continuous-subarray/solution/
    记录极值点，找到极值点区间内的最小和最大的坐标即为需要重排的区间
    因为最小的值要插入到最前的位置如i，第i位置原有的值后移，第i位置要记入重排的区间内
    参考文末图
    时间复杂度O(n)，空间复杂度O(1)
    * */
    public static int shortestSubarray4(int[] nums) {
        int min = Integer.MAX_VALUE, max = Integer.MIN_VALUE;
        for (int i = 1; i < nums.length; i++) {
            // 正向时正常应该上升，但是如果下降则记录下降的数的值
            if (nums[i - 1] > nums[i]) {
                // min为下降中的最小值，极值点
                min = Math.min(min, nums[i]);
            }
        }
        // 没有逆序对
        if (min == Integer.MAX_VALUE) return 0;
        
        for (int i = nums.length - 2; i >= 0; i--) {
            // 逆向时正常应该下降，但是如果上升则记录上升的值
            if (nums[i] > nums[i + 1]) {
                // max为上升中的最大值，极值点
                max = Math.max(max, nums[i]);
            }
        }

        int lo, hi;
        for (lo = 0; lo < nums.length; lo++) {
            // 找到第一个大于min的值，则min应该在的位置是lo
            if (nums[lo] > min)
                break;
        }
        for (hi = nums.length - 1; hi >= 0; hi--) {
            // 找到第一个小于max的值，则max应该在的位置是hi
            if (nums[hi] < max)
                break;
        }
        return hi - lo + 1;
    }
    /*=====================================================================================*/

    public static void main(String[] args) {
        int[] nums1 = new int[]{1, 2, 4, 5, 3};
        int[] nums2 = new int[]{1, 2, 4, 5, 3};
        int[] nums3 = new int[]{1, 2, 4, 5, 3};
        int[] nums4 = new int[]{1, 2, 4, 5, 3};
        System.out.println(shortestSubarray1(nums1));
        System.out.println(shortestSubarray2(nums2));
        System.out.println(shortestSubarray3(nums3));
        System.out.println(shortestSubarray4(nums4));
    }
}
```

![](http://qiniu.limengting.site/leetcode581.png)