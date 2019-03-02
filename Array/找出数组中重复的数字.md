---
title: 剑指offer 找出数组中重复的数字
date: 2018-07-29 09:39:01
tags:
- algorithms
- Java
- Array
- 剑指offer
- Medium
categories: 算法
---

> 在一个长度为n的数组里的所有数字都在0到n-1的范围内。 数组中某些数字是重复的，但不知道有几个数字是重复的。也不知道每个数字重复几次。请找出数组中任意一个重复的数字。 例如，如果输入长度为7的数组{2,3,1,0,2,5,3}，那么对应的输出是第一个重复的数字2。
>
> Parameters:
> numbers: an array of integers
> length: the length of array numbers
> duplication: (Output) the duplicated number in the array number,
> length of duplication array is 1,so using duplication[0] = ? in implementation;
> Here duplication like pointor in C/C++, duplication[0] equal *duplication in C/C++
> 这里要特别注意~返回任意重复的一个，赋值duplication[0]
> Return value: true if the input is valid,
> and there are some duplications in the array number, otherwise false

```java
package array;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class FindOneOfDuplicateNumbers {
 
 /*=====================================================================================*/
    /*自想1：排序再遍历一遍找到第一个重复的数字
     * 时间复杂度O(nlogn)，空间复杂度O(1)，修改了原数组
     * 如果要求不修改原数组，拷贝一份之后再排序再遍历，时间复杂度不变，空间复杂度变为O(n)
     * */
    public static int findDuplicate1(int[] nums) {
        if (nums == null || nums.length <= 1) {
            throw new RuntimeException("invalid input!");
        }
        Arrays.sort(nums);
        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] == nums[i + 1])
                return nums[i];
        }
        throw new RuntimeException("cannot find duplicate number");
    }

    // 自想1改成要求的格式
    public boolean duplicate1(int numbers[],int length,int [] duplication) {
        if (numbers == null || numbers.length <= 1) {
            return false;
        }
        Arrays.sort(numbers);
        for (int i = 0; i <= numbers.length - 2; i ++) {
            if (numbers[i] == numbers[i + 1]) {
                duplication[0] = numbers[i];
                return true;
            }
        }
        return false;
    }


    /*=====================================================================================*/
    /*自想2：
     * 利用HashSet，如果有已经存在的则直接返回
     * 时间复杂度O(n)，空间复杂度O(n)
     * */
    public static int findDuplicate2(int[] nums) {
        if (nums == null || nums.length <= 1) {
            throw new RuntimeException("invalid input!");
        }
        Set<Integer> set = new HashSet<>();
        for (int num : nums) {
            if (set.contains(num)) {
                return num;
            } else {
                set.add(num);
            }
        }
        throw new RuntimeException("cannot find duplicate number");
    }

    // 自想2改成要求的格式
    public boolean duplicate2(int numbers[],int length,int [] duplication) {
        if (numbers == null || numbers.length <= 1) {
            return false;
        }
        Set<Integer> set = new HashSet<>();
        for (int num : numbers) {
            if (set.contains(num)) {
                duplication[0] = num;
                return true;
            }
            set.add(num);
        }
        return false;
    }

    /*=====================================================================================*/
    /*《剑指offer第2版》P39：
     * index[0,n-1] value[0,n-1]
     * 寻求index-value的对应关系，期待index==value
     * 从i=0开始看nums[i]是否==i，
     * 如果nums[i]==v(v!=i)，则看nums[v]，如果nums[v]==v则找到两个==v的数，则将v返回
     * 如果nums[v]!=v，则将nums[i]与nums[v]位置交换，期望把每个数都放在index==value的正确位置上
     * 时间复杂度O(n)，空间复杂度O(1)
     * */
    public static int findDuplicate3(int[] nums) {
        int i = 0;
        while (i < nums.length) {
            int v = nums[i];
            if (v == i) {
                i ++;
                continue;
            }
            if (nums[v] == v) {
                return v;
            }
            swap(nums, i, v);
        }
        throw new RuntimeException("cannot find duplicate number");
    }

    public static void swap(int[] nums, int i, int j) {
        int tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }
    
     // 改成要求的格式
     public boolean duplicate3(int numbers[],int length,int [] duplication) {
         if (numbers == null || numbers.length <= 1) {
             return false;
         }
         for (int i = 0; i < numbers.length; i ++) {
             while (numbers[i] != i) {
                 int v = numbers[i];
                 if (numbers[v] == v) {
                     duplication[0] = v;
                     return true;
                 }
                 swap(numbers, i, v);
             }
         }
         return false;
     }

    /*=====================================================================================*/

    public static void main(String[] args) {
        int[] nums1 = new int[]{3, 1, 3, 4, 1};
        System.out.println(findDuplicate1(nums1));
        System.out.println(findDuplicate2(nums1));
        System.out.println(findDuplicate3(nums1));
        System.out.println("=========================================================");
        int[] nums2 = new int[]{1, 2, 3, 2, 3, 5};
        System.out.println(findDuplicate1(nums2));
        System.out.println(findDuplicate2(nums2));
        System.out.println(findDuplicate3(nums2));
    }
}

```

