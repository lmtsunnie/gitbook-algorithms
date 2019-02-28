> Given an array of non-negative integers, you are initially positioned at the first index of the array.
>
> Each element in the array represents your maximum jump length at that position.
>
> Determine if you are able to reach the last index.
>
> **Example 1:**
>
> ```
> Input: [2,3,1,1,4]
> Output: true
> Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
> ```
>
> **Example 2:**
>
> ```
> Input: [3,2,1,0,4]
> Output: false
> Explanation: You will always arrive at index 3 no matter what. Its maximum
>              jump length is 0, which makes it impossible to reach the last index.
> ```

```java
package array;

enum Index {
    GOOD, BAD, UNKNOWN
}

public class leetcode55JumpGame {
    /**
     * 自想1：回溯（超时）
     * 如果nums[]中的每个数都>=nums.length - 1，那么所有的位置都可以选择走或者不走，时间复杂度O(2的n次方)，
     * 递归深度为n，空间复杂度O(n)
     */
    public boolean canJumpFromPosition1(int[] nums, int startIndex) {
        // 结束条件
        if (startIndex == nums.length - 1) {
            return true;
        }
        // 算出边界条件
        int nextMaxIndex = Math.min(startIndex + nums[startIndex], nums.length - 1);
        // 基于当前情况做深度搜索(一步步走到底)
        for (int nextIndex = startIndex + 1; nextIndex <= nextMaxIndex; nextIndex++) {
            if (canJumpFromPosition1(nums, nextIndex)) {
                return true;
            }
        }
        return false;
    }

    public boolean canJump1(int[] nums) {
        // 主函数调用子函数
        return canJumpFromPosition1(nums, 0);
    }

    /**
     * Solution区方法2：
     * 从前往后动态规划
     * 把每个点从该位置开始能否到达最后的位置记为一张表memo
     * memo[index]== GOOD则为index位置可以到达最后，BAD为不可以，UNKNOWN为未知
     * 起始的时候只有memo[nums.length - 1]== GOOD，其他的都为UNKNOWN
     * 从0开始回溯往后走，直到找到memo[index]==GOOD停止，否则返回BAD
     * ？？？为什么时间复杂度是O(n²)
     * 空间复杂度O(n)，表O(n)，递归深度O(n)
     */
    Index[] memo;

    public boolean canJump21(int[] nums) {
        memo = new Index[nums.length];
        for (int i = 0; i < nums.length - 1; i++) {
            memo[i] = Index.UNKNOWN;
        }
        memo[nums.length - 1] = Index.GOOD;
        return canJumpFromPosition2(nums, 0);
    }

    // 从前往后动态规划
    public boolean canJumpFromPosition2(int[] nums, int startIndex) {
        // 结束条件
        if (memo[startIndex] != Index.UNKNOWN) {
            return memo[startIndex] == Index.GOOD;
        }
        // 算出边界条件
        int nextMaxIndex = Math.min(startIndex + nums[startIndex], nums.length - 1);
        // 基于当前情况做深度搜索(一步步走到底)
        for (int nextIndex = startIndex + 1; nextIndex <= nextMaxIndex; nextIndex++) {
            if (canJumpFromPosition2(nums, nextIndex)) {
                memo[startIndex] = Index.GOOD;
                return true;
            }
        }
        memo[startIndex] = Index.BAD;
        return false;
    }

    /**
     * Solution区方法3：
     * 从后往前动态规划，从已知结果的一侧做动态规划效果更好
     * 时间复杂度O(n²)，空间复杂度O(n)
     */
    public boolean canJump3(int[] nums) {
        memo = new Index[nums.length];
        for (int i = 0; i < nums.length - 1; i++) {
            memo[i] = Index.UNKNOWN;
        }
        memo[nums.length - 1] = Index.GOOD;

        // 从后往前动态规划
        for (int startIndex = nums.length - 2; startIndex >= 0; startIndex--) {
            int nextMaxIndex = Math.min(startIndex + nums[startIndex], nums.length - 1);
            for (int nextIndex = startIndex + 1; nextIndex <= nextMaxIndex; nextIndex++) {
                if (memo[nextIndex] == Index.GOOD) {
                    memo[startIndex] = Index.GOOD;
                    break;
                }
            }
        }
        return memo[0] == Index.GOOD;
    }

    /**
     * Solution区方法4：
     * 从后往前走，直到走到0则返回true，走不到0则返回false
     * 时间复杂度O(n)，空间复杂度O(1)
     */
    public boolean canJump4(int[] nums) {
        int lastIndex = nums.length - 1;
        for (int startIndex = nums.length - 1; startIndex >= 0; startIndex--) {
            // 从startIndex开始可以走0 ~ nums[startIndex]步，
            // 停止的位置是startIndex ~ startIndex + nums[startIndex]，
            // 如果中间包含lastIndex则表示可以从startIndex走到lastIndex
            if (startIndex + nums[startIndex] >= lastIndex) {
                lastIndex = startIndex;
            }
        }
        return lastIndex == 0;
    }
}
```

