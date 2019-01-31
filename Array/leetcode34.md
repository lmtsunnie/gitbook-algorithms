> Given an array of integers nums sorted in ascending order,
> find the starting and ending position of a given target value.
>
> Your algorithm's runtime complexity must be in the order of O(log n).
>
> If the target is not found in the array, return [-1, -1].
>
> Example 1:
>
> Input: nums = [5,7,7,8,8,10], target = 8
>
> Output: [3,4]
>
> Example 2:
>
> Input: nums = [5,7,7,8,8,10], target = 6
>
> Output: [-1,-1]

```java
package array;

public class leetcode34FindFirstAndLastPositionOfElementInSortedArray {
    /**
     * 利用nums已经是有序的，正向搜找到第一个，反向搜找到最后一个
     * 时间复杂度O(n)，空间复杂度O(1)
     */
    public static int[] searchRange(int[] nums, int target) {
        int[] res = {-1, -1};
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == target) {
                res[0] = i;
                break;
            }
        }
        if (res[0] == -1) {
            return res;
        }
        for (int i = nums.length - 1; i >= 0; i--) {
            if (nums[i] == target) {
                res[1] = i;
                break;
            }
        }
        return res;
    }

    /**
     * 二分查找
     * 时间复杂度O(logn)，空间复杂度O(1)
     */
    public static int[] searchRange2(int[] nums, int target) {
        int[] res = {-1, -1};
        if (nums == null || nums.length == 0) {
            return res;
        }
        int leftIndex = findIndex(nums, target, true);
        // nums中不存在值为target的数
        if (leftIndex == nums.length || nums[leftIndex] != target) {
            return res;
        }
        res[0] = leftIndex;
        res[1] = findIndex(nums, target, false) - 1;
        return res;
    }

    public static int findIndex(int[] nums, int target, boolean left) {
        int lo = 0, hi = nums.length;
        while (lo < hi) {
            int mid = lo + ((hi - lo) >> 1);
            // 若target <= nums[mid]，hi = mid，在[lo, mid)中找
            // 若target > nums[mid]，lo = mid + 1，在[mid + 1, hi)中
            if (nums[mid] > target || (left && nums[mid] == target)) {
                hi = mid;
            } else {
                lo = mid + 1;
            }
        }
        return lo;
        // 查找左边的时候，循环结束时，lo为>=target的最小下标，故lo-1为<target的最大下标，有多个元素命中target时，保证返回下标最小的；查找失败时返回>=target的最小下标(lo)
        // 查找右边的时候，循环结束时，lo为>target的最小下标，故lo-1为<=target的最大下标，有多个元素命中target时，保证返回下标最大的；查找失败时返回<=target的最大下标(lo-1)
    }

    public static void main(String[] args) {
        int[] nums1 = {1, 2, 3, 3, 4, 4, 4, 5};
        int[] nums2 = {1, 4, 4, 4, 4, 4, 4, 5};
        int[] nums3 = {1, 4, 4, 5, 6, 7, 8, 9};
        int[] res1 = searchRange2(nums1, 4);
        int[] res2 = searchRange2(nums2, 4);
        int[] res3 = searchRange2(nums3, 4);
        System.out.println(res1[0] + " " + res1[1]);
        System.out.println(res2[0] + " " + res2[1]);
        System.out.println(res3[0] + " " + res3[1]);
    }
}

```

