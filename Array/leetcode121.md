---
title: LeetCode121 Best Time to Sell and Buy Stock
date: 2018-09-03 21:52:09
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- algorithms
---

>Say you have an array for which the ith element is the price of a given stock on day i.
>If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.
>Note that you cannot sell a stock before you buy one.
>
>Example 1:
>Input: [7,1,5,3,6,4]
>Output: 5
>Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
>Not 7-1 = 6, as selling price needs to be larger than buying price.
>Example 2:
>Input: [7,6,4,3,1]
>Output: 0
>Explanation: In this case, no transaction is done, i.e. max profit = 0.

```java
package array;

public class leetcode121BestTimeToSellAndBuyStock {
    /*=====================================================================================*/

    /* Solution区方法1：
        问题转化为求prices[j]−prices[i]的最大值, 其中要求j > i.
        时间复杂度O(n²)，空间复杂度O(1)
        */
    public static int bestTime1(int[] prices) {
        int maxProfit = 0;
        for (int i = 0; i < prices.length; i++) {
            for (int j = i + 1; j < prices.length; j++) {
                maxProfit = prices[j] - prices[i] > maxProfit ? prices[j] - prices[i] : maxProfit;
            }
        }
        return maxProfit;
    }

 /*=====================================================================================*/
    /*
    Solution区方法2：
    由于只要保证maxProfit是最大的profit就可以，maxPrice-minPrice要求最大
    遇到每一个都比较且试图更新minPrice和maxProfit
    就算minPrice出现在最后，由于最后只返回maxProfit，没有更新maxProfit还是不影响结果
    时间复杂度O(n)，空间复杂度O(1)
     */
    public static int bestTime2(int[] prices) {
        int maxProfit = 0;
        int minPrice = Integer.MAX_VALUE;
        for (int price : prices) {
            minPrice = price < minPrice ? price : minPrice;
            maxProfit = price - minPrice > maxProfit ? price - minPrice : maxProfit;
        }
        return maxProfit;
    }
    /*=====================================================================================*/
    /*
    Discuss区看到的：
    类比于最大子数列：最大子数列问题的目标是在数列的一维方向找到一个连续的子数列，使该子数列的和最大。
    例如，对一个数列 −2, 1, −3, 4, −1, 2, 1, −5, 4，其连续子数列中和最大的是 4, −1, 2, 1, 其和为6。

    Kadane算法：
    扫描一次整个数列的所有数值，在每一个扫描点计算以该点数值为结束点的子数列的最大和（正数和）。
    该子数列由两部分组成：【以前一个位置为结束点】的最大子数列、该位置的数值。
    用到了“最佳子结构”（以每个位置为终点的最大子数列都是基于其前一位置的最大子数列计算得出），可看成动态规划。
    maxCur = max(maxCur + x，x) 前面一段的maxCur要是是负数，还不如不要前面那段以当前值作为起始
    maxSoFar = max(maxCur, maxSoFar)
    最大子数列问题的一个变种是：如果数列中含有负数元素，允许返回长度为零的子数列。
    maxCur = max(maxCur + x, 0) 由于maxCur最小是0，如果x太小，使maxCur+x是个负数，就不要这段，取0
    maxSoFar = max(maxCur, maxSoFar)

    以本题类比于最大子数列问题的变种，prices[i]-prices[i-1]即差额相当于最大子数列中的每一个x
    例如prices = [7,1,5,3,6,4], 则差额 = [-6,4,-2,3,-2]，返回长度为0的子数列在这里就是不做股票的交易
      */
    public static int bestTime3(int[] prices) {
        int maxCur = 0, maxSoFar = 0;
        for(int i = 1; i < prices.length; i++) {
            maxCur = Math.max(0, maxCur + (prices[i] - prices[i-1]));
            maxSoFar = Math.max(maxCur, maxSoFar);
        }
        return maxSoFar;
    }

 /*=====================================================================================*/
    public static void main(String[] args) {
        int[] prices = new int[]{7,1,5,3,6,4};
        System.out.println(bestTime1(prices));
        System.out.println(bestTime2(prices));
        System.out.println(bestTime3(prices));
    }
}
```