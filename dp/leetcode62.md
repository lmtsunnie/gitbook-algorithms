---
title: LeetCode62 Unique Paths
date: 2018-10-17 22:22:15
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- dp动态规划
- matrix
- 背包问题
- algorithms
---

>A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).
>
>The robot can only move either down or right at any point in time.
>
>The robot is trying to reach the bottom-right corner of the grid(marked 'Finish' in the diagram below).
>
>How many possible unique paths are there?

<!-- more -->

![](http://qiniu.limengting.site/leetcode62.png)

> Above is a 7 x 3 grid. How many possible unique paths are there?
>
> Note: m and n will be at most 100.
>
> Example 1:
> Input: m = 3, n = 2
> Output: 3
>
> Explanation:
> From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
>
> 1. Right -> Right -> Down
> 2. Right -> Down -> Right
> 3. Down -> Right -> Right
>    Example 2:
>    Input: m = 7, n = 3
>    Output: 28

```java
package array;

public class leetcode62UniquePaths {
/*=====================================================================================*/
    /*自想1：
    * dp问题：
    * 用int[n][m]矩阵记录到达坐标为(i,j)的paths数量
    * 时间复杂度O(n²)，空间复杂度O(m*n)
    * */
    public static int uniquePaths(int m, int n) {
        int[][] paths = new int[n][m];
        for (int j = 0; j < m; j ++) {
            paths[0][j] = 1;
        }
        for (int i = 0; i < n; i ++) {
            paths[i][0] = 1;
        }
        for (int i = 1; i < n; i ++) {
            for (int j = 1; j < m; j ++) {
                paths[i][j] = paths[i - 1][j] + paths[i][j - 1];
            }
        }
        return paths[n - 1][m - 1];
    }
    /*=====================================================================================*/
    /*讨论区：
    * 每次只更新paths[i][j]，只需要用到paths[i-1][j]（第j列，即当前列）和paths[i][j-1]（第j-1列，即上一列）
    * 只保留当前列和上一列的值，用两个int[n]来表示两列
    * curCol[i][j]上面的数是curCol[i-1][j]，左边的数是preCol[i][j-1]
    * preCol其实就是未被覆盖的curCol的值，所以只要保留一列的值就可以了
    * 时间复杂度O(n²)，空间复杂度O(n)
    * */
    public static int uniquePaths2(int m, int n) {
        int[] curCol = new int[n];
        for (int i = 0; i < n; i ++) {
            curCol[i] = 1;
        }
        for (int j = 1; j < m; j ++) {
            for (int i = 1; i < n; i++) {
                curCol[i] += curCol[i - 1];
            }
        }
        return curCol[n - 1];
    }
    /*=====================================================================================*/
    public static void main(String[] args) {
        System.out.println(uniquePaths(3, 2));
        System.out.println(uniquePaths(7, 3));

        System.out.println(uniquePaths2(3,2));
        System.out.println(uniquePaths2(7,3));
    }
}

```