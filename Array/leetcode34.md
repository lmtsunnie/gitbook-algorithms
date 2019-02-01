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

方法2参见：[二分查找总结](https://limengting.site/2019/01/31/%E4%BA%8C%E5%88%86%E6%9F%A5%E6%89%BE%E7%9A%84%E5%90%84%E7%A7%8D%E5%8F%98%E5%BD%A2%E6%80%BB%E7%BB%93/)

```java
package array;

public class leetcode34FindFirstAndLastPositionOfElementInSortedArray {

    /**
     * 自想1：利用nums已经是有序的，正向搜找到第一个，反向搜找到最后一个
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
     * 自想2：二分查找
     * 时间复杂度O(logn)，空间复杂度O(1)
     */
    public static int[] searchRange2(int[] nums, int target) {
        int[] res = {-1, -1};
        if (nums == null || nums.length == 0) {
            return res;
        }
        int leftIndex = findLeftIndex(nums, target);
        // nums中不存在值为target的数
        if (leftIndex == -1) {
            return res;
        }
        res[0] = leftIndex;
        res[1] = findRightIndex(nums, target);
        return res;
    }

    /**
     * 1.2 查找第一个大于等于某个数的下标 加一个判断条件变成第一个等于某个数的下标
     * 例：int[] a = {1,2,2,2,4,8,10}，查找2，返回第一个2的下标1；
     * 查找3，返回4的下标4；查找4，返回4的下标4。如果没有大于等于target的元素，返回-1。
     */
    public static int findLeftIndex(int[] nums, int target) {
        if (nums == null || nums.length <= 0) {
            return -1;
        }
        int lo = 0, hi = nums.length - 1;
        while (lo <= hi) {
            int mid = lo + ((hi - lo) >> 1);
            // target < nums[mid]，target在左半段，
            // 如果target==nums[mid]，虽然hi = mid - 1，但是最后在左半段没有找到更小的，最后会返回mid，如{0,1,1,2,4,8,10}
            if (target <= nums[mid]) {
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        }
        // 如果target大于数组最后一个元素，lo最后变为nums.length，即没有元素大于target，需要返回-1。
        return lo <= nums.length - 1 && nums[lo] == target ? lo : -1;
    }

    /**
     * 1.3 从右边起查找第一个小于等于某个数的下标 加一个判断条件变成最后一个等于某个数的下标
     * 例，int[] a = {1,2,2,2,4,8,10}，查找2，返回最后一个2的下标3；查找3，返回最后一个2的下标3；
     * 查找4，返回4的下标4。如果没有<=target的元素，返回-1。
     */
    public static int findRightIndex(int[] nums, int target) {
        if (nums == null || nums.length <= 0) {
            return -1;
        }
        int lo = 0, hi = nums.length - 1;
        while (lo <= hi) {
            int mid = lo + ((hi - lo) >> 1);
            // target < nums[mid]，target在左半段
            if (target < nums[mid]) {
                hi = mid - 1;
                // target > nums[mid]，target在右半段，
                // 如果target==nums[mid]，虽然lo = mid + 1，但是最后在右半段没有找到更大的，target < nums[mid]，hi会返回前一个数，如{0,1,1,2,4,8,10}
            } else {
                lo = mid + 1;
            }
        }
        // 如果target小于数组第一个元素，hi最后变为-1，即没有元素<=target，需要返回-1。
        // hi = lo - 1
        return hi >= 0 && nums[hi] == target? hi : -1;
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

