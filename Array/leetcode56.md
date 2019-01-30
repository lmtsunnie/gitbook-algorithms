> Given a collection of intervals, merge all overlapping intervals.
>
> Example 1:
>
> Input: [[1,3],[2,6],[8,10],[15,18]]
>
> Output: [[1,6],[8,10],[15,18]]
>
> Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].
>
> Example 2:
>
> Input: [[1,4],[4,5]]
>
> Output: [[1,5]]
>
> Explanation: Intervals [1,4] and [4,5] are considered overlapping.

```java
package array;

import common.Interval;

import java.util.*;

/**
 * Definition for an interval.
 * public class Interval {
 *     int start;
 *     int end;
 *     Interval() { start = 0; end = 0; }
 *     Interval(int s, int e) { start = s; end = e; }
 * }
 */
public class leetcode56MergeIntervals {
    /**
     * 答案区方法2：
     * 先把intervals按start从小到大排序，然后用LinkedList<Interval> res存储结果，(因为增删多所以用LinkedList而不用ArrayList)
     * 遍历intervals，每次拿res.getLast().end和interval.start比较，如果有重叠则更新res.getLast().end
     * 如果没有重叠，直接将res.add(interval)
     * 时间复杂度：排序O(nlogn)+ for循环O(n) = O(nlogn)，空间复杂度O(1)
     */
    private class IntervalComparator implements Comparator<Interval> {
        @Override
        public int compare(Interval o1, Interval o2) {
            return Integer.compare(o1.start, o2.start);
        }
    }

    public List<Interval> merge(List<Interval> intervals) {
        if (intervals == null || intervals.size() <= 1) {
            return intervals;
        }
        Collections.sort(intervals, new IntervalComparator());
        LinkedList<Interval> res = new LinkedList<>();
        for (Interval interval : intervals) {
            if (res.isEmpty() || res.getLast().end < interval.start) {
                res.add(interval);
            } else {
                res.getLast().end = Integer.max(res.getLast().end, interval.end);
            }
        }
        return res;
    }
}
```

