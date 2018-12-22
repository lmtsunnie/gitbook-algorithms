---
title: LeetCode621 Task Scheduler
date: 2018-10-18 17:35:55
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- 字符数组
- question
- algorithms
---

> Given a char array representing tasks CPU need to do. It contains capital letters A to Z where different letters represent different tasks. Tasks could be done without original order. Each task could be done in one interval. For each interval, CPU could finish one task or just be idle.
>
> However, there is a non-negative cooling interval n that means between two same tasks,
> there must be at least n intervals that CPU are doing different tasks or just be idle.
>
> You need to return the least number of intervals the CPU will take to finish all the given tasks.
>
> Example:
> Input: tasks = ["A","A","A","B","B","B"], n = 2
> Output: 8
> Explanation: A -> B -> idle -> A -> B -> idle -> A -> B.
>
> Note:
> The number of tasks is in the range [1, 10000].
> The integer n is in the range [0, 100].

```java
package array;

import java.util.Arrays;

public class leetcode621TaskScheduler {
 /*=====================================================================================*/
 /*自想1：
 * 按出现次数从大到小重新排列，并把字符数组转换成int数组，
 * index为char-'A'，value为这个char出现的次数
 * 先排出现次数多的，再排出现次数少的
 * 以次数最多的char满足n间隔算出总数为
 * (max-1)*n+次数最多的char的种类maxCount，如A,B并列最多，maxCount = 2
 * 如果这个数>sum，那么取这个数，
 * 如果这个数<sum，可以证明？？？（其实我也不知道怎么证明）这个数后面的一串能不插入idle就排好，取sum
 * 时间复杂度O(n)，空间复杂度O(26)
 * */
    public static int taskScheduler(char[] tasks, int n) {
        int[] nums = new int[26];
        for (int i = 0; i < tasks.length; i ++) {
            nums[tasks[i] -'A'] ++;
        }
        Arrays.sort(nums);
        int max = nums[25];
        int maxCount = 0;
        for (int i = 25; i >= 0; i --) {
            if (nums[i] == max) {
                maxCount ++;
            }
        }
        return Math.max((max - 1) * (n + 1) + maxCount, tasks.length);
    }
    
/*=====================================================================================*/
    public static void main(String[] args) {
        char[] tasks = new char[]{'A','A','A','B','B','B'};
        System.out.println(taskScheduler(tasks,2));
    }
}
```