---
title: LeetCode48 Rotate Image
date: 2018-10-18 00:33:18
categories: 算法
tags: 
- LeetCode
- Top 100 Liked Questions
- Array
- Medium
- Java
- matrix
- rotate
- algorithms
---

> You are given an n x n 2D matrix representing an image.
>
> Rotate the image by 90 degrees (clockwise).

<!-- more -->

> Note:
> You have to rotate the image in-place,
> which means you have to modify the input 2D matrix directly.
> DO NOT allocate another 2D matrix and do the rotation.
>
> Example 1:
> Given input matrix =
> [
> ​    [1,2,3],
> ​    [4,5,6],
> ​    [7,8,9]
> ],
>
> rotate the input matrix in-place such that it becomes:
> [
> ​    [7,4,1],
> ​    [8,5,2],
> ​    [9,6,3]
> ]
>
> Example 2:
> Given input matrix =
> [
> ​    [ 5, 1, 9,11],
> ​    [ 2, 4, 8,10],
> ​    [13, 3, 6, 7],
> ​    [15,14,12,16]
> ],
>
> rotate the input matrix in-place such that it becomes:
> [
> ​    [15,13, 2, 5],
> ​    [14, 3, 4, 1],
> ​    [12, 6, 8, 9],
> ​    [16, 7,10,11]
> ]

```java
package array;

import static format.printMatrix.printNDegreeMatrix;

public class leetcode48RotateImage {
 /*=====================================================================================*/
    /*
    * 自想1：纯数学方法找规律
    * 把矩阵像剥洋葱一样分成一层一层的，每层都是正方形四条等长的边，边长度设为n，层数为j，最外面一层为0，
    * 逐渐向里对每一层四个四个数分组进行旋转
    * 时间复杂度 4n/4+ 4(n-1)/4 + ... + 1 = O(n²)，空间复杂度O(1)
    * */
    public static void rotateImage(int[][] matrix) {
        rotateImageHelper(matrix, matrix.length);
    }

    public static void rotateImageHelper(int[][] matrix, int n) {
        for (int i = n, j = 0; i > 1; i = i - 2, j ++) {
            rotateImageEdge(matrix, i, j);
        }
    }

    public static void rotateImageEdge(int[][] matrix, int n, int j) {
        // j表示从外向内的层数
        for (int i = 0; i < n - 1; i ++) {
            swapFourNumbers(matrix, n, i, j);
        }
    }

    public static void swapFourNumbers(int[][] matrix, int n, int i, int j) {
        // 左(n - 1 - i, 0) 右(i, n - 1)
        // 上(0, i) 下(n - 1, n - 1 - i)
        // 上->右->下->左(->上)，逆序操作，不然覆盖了
        // j层在坐标下加上(j,j)
        int tmp = matrix[j][i + j]; // 把上存起来
        matrix[j][i + j] = matrix[n - 1 - i + j][j];                // 左的值给上
        matrix[n - 1 - i + j][j] = matrix[n - 1 + j][n - 1 - i + j]; // 下的值给左
        matrix[n - 1 + j][n - 1 - i + j] = matrix[i + j][n - 1 + j];  // 右的值给下
        matrix[i + j][n - 1 + j] = tmp;  // 上的值给右
    }
    /*=====================================================================================*/
    /* 讨论区：
     * clockwise rotate
     * first reverse up to down, then transpose the symmetry
     * 1 2 3     7 8 9     7 4 1
     * 4 5 6  => 4 5 6  => 8 5 2
     * 7 8 9     1 2 3     9 6 3
     *
     * anticlockwise rotate
     * first reverse left to right, then transpose the symmetry
     * 1 2 3     3 2 1     3 6 9
     * 4 5 6  => 6 5 4  => 2 5 8
     * 7 8 9     9 8 7     1 4 7
     * 时间复杂度O(n²)，空间复杂度O(1)
     */
    public static void rotateImage2(int[][] matrix) {
        // upDownReverse(matrix);
        upDownReverse2(matrix);
        transpose(matrix);
    }

    // 转置函数
    public static void transpose(int[][] matrix) {
        for (int i = 0; i < matrix.length; i ++) {
            for (int j = 0; j <= i; j ++) {
                int tmp = matrix[i][j];
                matrix[i][j] = matrix[j][i];
                matrix[j][i] = tmp;
            }
        }
    }

    // 每行为一个单位，使行逆序的函数
    public static void upDownReverse(int[][] matrix) {
        for (int i = 0; i < matrix.length / 2; i ++) {
            rowSwap(matrix, i, matrix.length - 1 - i);
        }
    }

    // 两行互换函数
    public static void rowSwap(int[][] matrix, int a, int b) {
        int[] tmp = new int[matrix.length];
        for (int i = 0; i < matrix.length; i ++) {
            tmp[i] = matrix[a][i]; // 存a行数据在tmp中
            matrix[a][i] = matrix[b][i]; // 把b行数据给a行
            matrix[b][i] = tmp[i]; // 把tmp中a行的数据恢复到b行中
        }
    }

    // upDownReveerse和rowSwap函数需要O(n)空间，优化成只需要O(1)空间
    // 只要matrix[i][j]和matrix[n-1-i][j]互换
    public static void upDownReverse2(int[][] matrix) {
        int tmp = 0;
        for (int i = 0; i < matrix.length / 2; i ++) {
            for (int j = 0; j < matrix.length; j ++) {
                tmp = matrix[i][j];
                matrix[i][j] = matrix[matrix.length - 1 - i][j];
                matrix[matrix.length - 1 - i][j] = tmp;
            }
        }
    }
    
/*=====================================================================================*/
    public static void main(String[] args) {
        int[][] matrix1 = new int[][]{{1,2,3},{4,5,6},{7,8,9}};
        int[][] matrix2 = new int[][]{{5, 1, 9,11},{2, 4, 8,10}, {13, 3, 6, 7}, {15,14,12,16}};
        int[][] matrix3 = new int[][]{{1,2,3},{4,5,6},{7,8,9}};
        int[][] matrix4 = new int[][]{{5, 1, 9,11},{2, 4, 8,10}, {13, 3, 6, 7}, {15,14,12,16}};
        printNDegreeMatrix(matrix1);
        rotateImage(matrix1);
        System.out.println();
        printNDegreeMatrix(matrix1);
        System.out.println();
        printNDegreeMatrix(matrix2);
        rotateImage(matrix2);
        System.out.println();
        printNDegreeMatrix(matrix2);
        System.out.println("========================");
        printNDegreeMatrix(matrix3);
        rotateImage2(matrix3);
        System.out.println();
        printNDegreeMatrix(matrix3);
        System.out.println();
        printNDegreeMatrix(matrix4);
        rotateImage2(matrix4);
        System.out.println();
        printNDegreeMatrix(matrix4);
    }
}
```

打印函数：

```java
package format;

public class printMatrix {
    public static void printNDegreeMatrix(int[][] matrix) {
        for (int[] nums : matrix) {
            for (int num : nums) {
                System.out.print(num + " ");
            }
            System.out.println();
        }
    }

    public static void main(String[] args) {
        int[][] matrix = new int[][]{{1,2,3},{4,5,6},{7,8,9}};
        printNDegreeMatrix(matrix);
    }
}
```

