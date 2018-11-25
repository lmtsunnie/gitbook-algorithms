---
title: bfs/dfs总结
date: 2018-11-10 21:00:48
categories: 算法
tags:
- Java
- algorithms
- bfs/dfs
- handwriting
---

![](http://qiniu.limengting.site/work21.jpg)

bfs广度优先搜索/dfs深度优先搜索相关算法题的思路总结。

<!-- more -->

# 广度优先搜索（bfs）

广度优先搜索在进一步遍历图中顶点之前，先访问当前顶点的所有邻接结点。

1. 首先选择一个顶点作为起始结点，并将其染成灰色，其余结点为白色。

2. 将起始结点放入队列中。

3. 从队列首部选出一个顶点，并找出所有与之邻接的结点，将找到的邻接结点放入队列尾部，将已访问过结点涂成黑色，没访问过的结点是白色。如果顶点的颜色是灰色，表示已经发现并且放入了队列，如果顶点的颜色是白色，表示还没有发现

4. 按照同样的方法处理队列中的下一个结点。
   基本就是出队的顶点变成黑色，在队列里的是灰色，还没入队的是白色。

   用一副图来表达这个流程如下：

![](http://qiniu.limengting.site/bfs.png)



从顶点1开始进行广度优先搜索：

1. 初始状态，从顶点1开始，队列 = {1}
2. 访问1的邻接顶点，1出队变黑，2,3入队，队列 = {2, 3}
3. 访问2的邻接结点，2出队，4入队，队列 = {3, 4}
4. 访问3的邻接结点，3出队，队列 = {4}
5. 访问4的邻接结点，4出队，队列 = {空}
    结点5对于1来说不可达。

## 给一个邻接矩阵实现bfs输出

```java
import java.util.LinkedList;
import java.util.Queue;

public class bfs {
    /* matrix为n*n邻接矩阵：
    * matrix[i][j]为1表示有从i到j的有向边
    * 为0表示没有从i到j的有向边
    * */
    public static void main(String[] args) {
        // 1,2,3,4,5 五个节点
        int[][] matrix = {
                {0, 1, 1, 0, 0},
                {0, 0, 1, 1, 0},
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 1, 1, 0}
                };
        bfs(matrix);
    }

    public static void bfs(int[][] matrix) {
        if (matrix.length != matrix[0].length) {
            return;
        }
        int n = matrix.length;
        boolean[] visited = new boolean[n]; // 全部会初始化为false
        for (int i = 0; i < n; i ++) {
            if (visited[i]) continue;
            helper(matrix, visited, i);
        }
    }

    public static void helper(int[][] matrix, boolean[] visited, int start) {
        Queue<Integer> queue = new LinkedList<>();
        queue.add(start);
        visited[start] = true;
        while (!queue.isEmpty()) {
            int pop = queue.poll();
            System.out.println((pop + 1) + " ");
            for (int i = 0; i < matrix.length; i ++) {
                if (!visited[i] && matrix[pop][i] == 1) {
                    visited[i] = true; // visited表示第i号节点(i+1)是否已经入队
                    queue.add(i);
                }
            }
        }
    }
}
```

## bfs相关问题

### 二叉树层次遍历

```java
    // 先进先出，用队列实现。弹一个出来，把左边右边加进去
    // bfs的思想
    public static void layerTraversal(Node root) {
        if (root == null) return;
        Queue<Node> queue = new LinkedList<>();
        queue.add(root);
        Node cur;
        while (!queue.isEmpty()) {
            cur = queue.poll();
            System.out.print(cur.value + " ");
            if (cur.left != null)
                queue.add(cur.left);
            if (cur.right != null)
                queue.add(cur.right);
        }
    }
```

# 深度优先遍历（dfs）

深度优先搜索在搜索过程中访问某个顶点后，需要递归地访问此顶点的所有未访问过的相邻顶点。
初始条件下所有节点为白色，选择一个作为起始顶点，按照如下步骤遍历：

1. 选择起始顶点涂成灰色，表示还未访问
2. 从该顶点的邻接顶点中选择一个，继续这个过程（即再寻找邻接结点的邻接结点），一直深入下去，直到一个顶点没有邻接结点了，涂黑它，表示访问过了
3. 回溯到这个涂黑顶点的上一层顶点，再找这个上一层顶点的其余邻接结点，继续如上操作，如果所有邻接结点往下都访问过了，就把自己涂黑，再**回溯**到更上一层。
4. 上一层继续做如上操作，知道所有顶点都访问过。
   用图可以更清楚的表达这个过程：

![](http://qiniu.limengting.site/dfs.png)

从顶点1开始做深度搜索：

1. 初始状态，从顶点1开始
2. 依次访问过顶点1,2,3后，终止于顶点3
3. 从顶点3回溯到顶点2，继续访问顶点5，并且终止于顶点5
4. 从顶点5回溯到顶点2，并且终止于顶点2
5. 从顶点2回溯到顶点1，并终止于顶点1
6. 从顶点4开始访问，并终止于顶点4

## 给一个邻接矩阵实现dfs输出

```java
public class dfs {
    /* matrix为n*n邻接矩阵：
     * matrix[i][j]为1表示有从i到j的有向边
     * 为0表示没有从i到j的有向边
     * */
    public static void main(String[] args) {
        // 1,2,3,4,5 五个节点
        int[][] matrix = {
                { 0, 1, 1, 0, 0 },
                { 0, 0, 1, 0, 1 },
                { 0, 0, 1, 0, 0 },
                { 1, 1, 0, 0, 1 },
                { 0, 0, 1, 0, 0 }
        };
        dfs(matrix);
    }

    public static void dfs(int[][] matrix) {
        if (matrix.length != matrix[0].length) {
            return;
        }
        int n = matrix.length;
        boolean[] visited = new boolean[n]; // 全部会初始化为false
        for (int i = 0; i < n; i ++) {
            if (visited[i]) continue;
            helper(matrix, visited, i);
        }
    }
    public static void helper(int[][] matrix, boolean[] visited, int start) {
        visited[start] = true;
        for (int i = 0; i < matrix.length; i ++) {
            if (!visited[i] && matrix[start][i] == 1) {
                helper(matrix, visited, i);
            }
        }
        System.out.println(start + 1);
    }
}
```

## dfs与backtracking相关问题

### 给定一个数字n，字典序输出[1, n]的整数

> Given an integer *n*, return 1 - *n* in lexicographical order.
>
> For example, given 13, return: [1,10,11,12,13,2,3,4,5,6,7,8,9].
>
> Please optimize your algorithm to use less time and space. The input size may be as large as 5,000,000.

> 解答链接 [LeetCode386 Lexicographical Numbers](https://limengting.site/2018/11/10/leetcode386/)

```java
	public static List<Integer> lexicalOrder(int n) {
        List<Integer> list = new ArrayList<>();
        for (int i = 1; i <= 9; i ++) {
            dfs(list, n, i);
        }
        return list;
    }

    public static void dfs(List<Integer> list, int n, int cur) {
        if (cur > n) return;
        list.add(cur);
        for (int i = 0; i <= 9; i ++) {
            dfs(list, n, 10 * cur + i);
        }
    }
```

### 给定一个没有重复数字的整数集，输出它的所有子集

> Given a set of distinct integers, nums, return all possible subsets (the power set).
> Note: The solution set must not contain duplicate subsets.
>
> Example:
> Input: nums = [1,2,3]
> Output:
> [
>   [3],
>   [1],
>   [2],
>   [1,2,3],
>   [1,3],
>   [2,3],
>   [1,2],
>   []
> ]

> 解答链接 [LeetCode78 Subsets](https://limengting.site/2018/10/16/leetcode78/)

```java
	public List<List<Integer>> subsets(int[] nums) {
        if (nums == null || nums.length <= 0) {
            return null;   
        }
        List<List<Integer>> lists = new ArrayList<>();
        backtrack(lists, new ArrayList<>(), nums, 0);
        return lists;
    }
    
    public void backtrack(List<List<Integer>> lists, List<Integer> tmpList, int[] nums, int start) {
        lists.add(new ArrayList<>(tmpList));
        for (int i = start; i < nums.length; i ++) {
            tmpList.add(nums[i]);
            backtrack(lists, tmpList, nums, i + 1);
            tmpList.remove(tmpList.size() - 1);
        }
    }
```

### 给定一个可能含有重复数字的整数集，输出它的所有子集

> Given a collection of integers that might contain duplicates, nums, return all possible subsets (the power set).
>
> Note: The solution set must not contain duplicate subsets.
> Example:
> Input: [1,2,2]
> Output:
> [
>   [2],
>   [1],
>   [1,2,2],
>   [2,2],
>   [1,2],
>   []
> ]

> 解答链接 [LeetCode90 Subsets II](https://limengting.site/2018/10/18/leetcode90/)

```java
    public List<List<Integer>> subsetsWithDup(int[] nums) {
        if (nums == null || nums.length <= 0) {
            return null;
        }
        Arrays.sort(nums);
        List<List<Integer>> lists = new ArrayList<>();
        backtrack(lists, new ArrayList<>(), nums, 0);
        return lists;
    }
    
    public void backtrack(List<List<Integer>> lists, List<Integer> tmpList, int[] nums, int start) {
        lists.add(new ArrayList<>(tmpList));
        for (int i = start; i < nums.length; i ++) {
            if (i >= start + 1 && nums[i - 1] == nums[i]) continue; // i - 1 >= start
            tmpList.add(nums[i]);
            backtrack(lists, tmpList, nums, i + 1);
            tmpList.remove(tmpList.size() - 1);
        }
    }
```

### 给定一个不含重复数字的整数数组candidates和一个target，candidates中的数每个可以使用一次或多次，找到所有和为target的集合

> Given a set of candidate numbers (candidates) (without duplicates) and a target number (target), find all unique combinations in candidates where the candidate numbers sums to target.
>
> The same repeated number may be chosen from candidates unlimited number of times.
>
> Note:
> All numbers (including target) will be positive integers.
> The solution set must not contain duplicate combinations.
>
> Example 1:
>
> Input: candidates = [2,3,6,7], target = 7,
> A solution set is:
> [
> [7],
> [2,2,3]
> ]
>
> Example 2:
>
> Input: candidates = [2,3,5], target = 8,
> A solution set is:
> [
> [2,2,2,2],
> [2,3,3],
> [3,5]
> ]

> 解答连接 [LeetCode39 Combination Sum](https://limengting.site/2018/10/18/leetcode39/)

```java
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        if (candidates == null || candidates.length <= 0) {
            return null;
        }
        List<List<Integer>> lists = new ArrayList<>();
        backtrack(lists, new ArrayList<>(), candidates, 0, target);
        return lists;
    }
    
    public void backtrack(List<List<Integer>> lists, List<Integer> tmpList, int[] candidates, int start, int remain) {
        if (remain < 0) return;
        else if (remain == 0) {
            lists.add(new ArrayList<>(tmpList));
        } else {
            for (int i = start; i < candidates.length; i ++) {
                tmpList.add(candidates[i]);
                backtrack(lists, tmpList, candidates, i, remain - candidates[i]);
                tmpList.remove(tmpList.size() - 1);
            }
        }
    }
```

### 给定一个可能含有重复数字的整数数组candidates和一个target，candidates中的数每个只能使用至多一次，找到所有和为target的集合

> Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sums to target.
>
> Each number in candidates may only be used once in the combination.
>
> Note:
> All numbers (including target) will be positive integers.
> The solution set must not contain duplicate combinations.
>
> Example 1:
>
> Input: candidates = [10,1,2,7,6,1,5], target = 8,
> A solution set is:
> [
>   [1, 7],
>   [1, 2, 5],
>   [2, 6],
>   [1, 1, 6]
> ]
>
> Example 2:
>
> Input: candidates = [2,5,2,1,2], target = 5,
> A solution set is:
> [
>   [1,2,2],
>   [5]
> ]

> 解答链接 [LeetCode40 Combination Sum II](https://limengting.site/2018/11/11/leetcode40/)

```java
    public List<List<Integer>> combinationSum2(int[] candidates, int target) {
        if (candidates == null || candidates.length <= 0) {
            return null;
        }
        Arrays.sort(candidates);
        List<List<Integer>> lists = new ArrayList<>();
        backtrack(lists, new ArrayList<>(), candidates, 0, target);
        return lists;
    }
    
    public void backtrack(List<List<Integer>> lists, List<Integer> tmpList, int[] candidates, int start, int remain) {
        if (remain < 0) return;
        else if (remain == 0) {
            lists.add(new ArrayList<>(tmpList));
        } else {
            for (int i = start; i < candidates.length; i ++) {
                if (i >= start + 1 && candidates[i - 1] == candidates[i]) {
                    continue;
                }
                tmpList.add(candidates[i]);
                backtrack(lists, tmpList, candidates, i + 1, remain - candidates[i]);
                tmpList.remove(tmpList.size() - 1);
            }
        }
    }
```

### 给定一个不含有重复数字的整数的集合nums[]，返回其全排列

> Given a collection of distinct integers, return all possible permutations.
>
> Example:
>
> Input: [1,2,3]
> Output:
> [
>   [1,2,3],
>   [1,3,2],
>   [2,1,3],
>   [2,3,1],
>   [3,1,2],
>   [3,2,1]
> ]

> 解答链接 [LeetCode46 Permutations](https://limengting.site/2018/11/11/leetcode46/)

```java
	public List<List<Integer>> permute(int[] nums) {
        if (nums == null || nums.length <= 0) {
            return null;
        }
        List<List<Integer>> lists = new ArrayList<>();
        backtrack(lists, new ArrayList<>(), nums);
        return lists;
    }
    public void backtrack(List<List<Integer>> lists, List<Integer> tmpList, int[] nums) {
        if (tmpList.size() == nums.length) {
            lists.add(new ArrayList<>(tmpList));
        } else {
            for (int i = 0; i < nums.length; i ++) {
                if (tmpList.contains(nums[i])) {
                    continue;
                }
                tmpList.add(nums[i]);
                backtrack(lists, tmpList, nums);
                tmpList.remove(tmpList.size() - 1);
            }
        }
    }
```

### 给定一个可能含有重复数字的整数的集合nums[]，返回其不重复的全排列

> Given a collection of numbers that might contain duplicates, return all possible unique permutations.
>
> Example:
>
> Input: [1,1,2]
> Output:
> [
>   [1,1,2],
>   [1,2,1],
>   [2,1,1]
> ]

> 解答链接 [LeetCode47 Permutations II](https://limengting.site/2018/11/11/leetcode47/)

```java
    /*		理解!used(i-1)：
            首先要明白i作为数组内序号，i是唯一的
            给出一个排好序的数组，[1,2,2]
            第一层递归            第二层递归            第三层递归
            [1]                    [1,2]                [1,2,2]
        序号:[0]                    [0,1]                [0,1,2]
            这种都是OK的，但当第二层递归i扫到的是第二个"2"，情况就不一样了
            [1]                    [1,2]                [1,2,2]            
        序号:[0]                    [0,2]                [0,2,1]
            所以当i=2，第二层递归判断的时候!used(1)就变成了true，不会再继续递归下去，跳出循环
        */
    public List<List<Integer>> permuteUnique(int[] nums) {
        if (nums == null || nums.length <= 0) {
            return null;
        }
        Arrays.sort(nums);
        List<List<Integer>> lists = new ArrayList<>();
        backtrack(lists, new ArrayList<>(), nums, new boolean[nums.length]);
        return lists;
    }

    public void backtrack(List<List<Integer>> lists, List<Integer> tmpList, int[] nums, boolean[] used) {
        if (tmpList.size() == nums.length) {
            lists.add(new ArrayList<>(tmpList));
        } else {
            for (int i = 0; i < nums.length; i++) {
                if (used[i] || (i >= 1 && nums[i - 1] == nums[i] && !used[i - 1])) {
                    continue;
                }
                used[i] = true;
                tmpList.add(nums[i]);
                backtrack(lists, tmpList, nums, used);
                used[i] = false;
                tmpList.remove(tmpList.size() - 1);
            }
        }
    }
}
```



