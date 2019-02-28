---
title: 剑指offer 二维数组中的查找
date: 2018-07-29 13:58:09
tags:
- algorithms
- Java
- 剑指offer
- matrix
- Easy
categories: 算法
---

> 在一个二维数组中（每个一维数组的长度相同），每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。

<!-- more -->

```java
package matrix;

public class 二维数组中的查找 {

    /*自想1：
    以左下角为基准进行范围的缩小，查找的范围为行在[0,i]，列在[j,n-1]的矩形中
    target大于基准则划掉基准所在的列，target小于基准则划掉基准所在的行，逐渐缩小范围
    时间复杂度O(m+n)，空间复杂度O(1)
    */
    public static boolean find(int target, int[][] array) {
        if (array == null || array.length <= 0 || array[0].length <= 0) {
            return false;
        }
        int m = array.length;
        int n = array[0].length;
        int i = m - 1, j = 0;
        while (i >= 0 && j <= n - 1) {
            if (target < array[i][j]) {
                i--;
            } else if (target > array[i][j]) {
                j++;
            } else {
                return true;
            }
        }
        return false;
    }


    public static void main(String[] args) {
        int[][] array = new int[][]{{1, 2, 8, 9}, {2, 4, 9, 12}, {4, 7, 10, 13}, {6, 8, 11, 15}};
        System.out.println(find(15, array));
    }
}
```