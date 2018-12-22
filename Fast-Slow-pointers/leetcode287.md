---
title: LeetCode287 Find the Duplicate Number
date: 2018-10-17 17:51:46
categories: 算法
tags:
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- Fast&Slow pointers
- Linked List
- algorithms
---

> Given an array nums containing n + 1 integers where each integer is between 1 and n (inclusive), prove that at least one duplicate number must exist.
>
> Assume that there is only one duplicate number, find the duplicate one.
>
> Example 1:
> Input: [1,3,4,2,2]
> Output: 2
>
> Example 2:
> Input: [3,1,3,4,2]
> Output: 3
>
> Note:
> You must not modify the array (assume the array is read only).
> You must use only constant, O(1) extra space.
> Your runtime complexity should be less than O(n2).
> There is only one duplicate number in the array, but it could be repeated more than once.

```java
package array;

public class leetcode287FindTheDuplicateNumber {
    public static int findTheDuplicateNumber1(int[] nums) {
       /*自想1：用两个指针遍历，时间复杂度O(n²)，空间复杂度O(1)
        初始p1指向nums[0],p2指向nums[1]，
        先固定指针1，用尾指针去找与头指针相同的数，找到则返回，
        没找到则头指针后移一步，继续用尾指针找与头指针相同的数
        但是没有利用到n+1个数都在[1,n]之间的条件
        */
        for (int i = 0; i < nums.length - 1; i ++) {
            for (int j = i + 1; j < nums.length; j ++) {
                if (nums[i] == nums[j]) {
                    return nums[i];
                }
            }
        }
        return -1;
    }

    public static int findTheDuplicateNumber2(int[] nums) {
        /*Solution区：
        * 根据题意，n+1个数index[0,n]，value[1,n]
        * 将一个k-v当成一个节点，k表示节点本身，v表示next（下一个将要访问的节点），
        * n+1个数组成的n+1个k-v可以看成一个沿着next访问的单链表
        * 当两个不同的index的value相同时，相当于单链表形成环
        * 所以问题相当于找单链表入环节点的位置
        * 遍历两圈，时间复杂度O(n)，空间复杂度O(1)
        *
        * 入环节点的求法：快指针一次走两步，慢指针一次走一步，
        * 当两个指针相遇时快指针回到头节点，接下来快慢指针都一次走一步，再次相遇时就是入环节点的位置
        * */
        int fast = 0, slow = 0;
        // 快指针一次走两步，慢指针一次走一步
        while (fast < nums.length) {
            slow = nums[slow];
            fast = nums[nums[fast]];
            if (slow == fast) { // 第一次相遇
                break;
            }
        }
        // 越界还未相遇，退出
        if (fast >= nums.length) return -1;
        // 快指针回到起点，快指针和慢指针都一次走一步
        fast = 0;
        while (fast < nums.length) {
            slow = nums[slow];
            fast = nums[fast];
            if (slow == fast) {
                return slow; // 再次相遇即为所求
            }
        }
        return -1;
    }

    public static void main(String[] args) {
        int[] nums1 = new int[]{3,1,3,4,2};
        System.out.println(findTheDuplicateNumber1(nums1));
        System.out.println(findTheDuplicateNumber2(nums1));
        System.out.println("=========================================================");
        int[] nums2 = new int[]{1,2,3,4,3,5};
        System.out.println(findTheDuplicateNumber1(nums2));
        System.out.println(findTheDuplicateNumber2(nums2));
    }
}
```