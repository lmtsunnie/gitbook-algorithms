> 输入一个链表，输出该链表中倒数第k个结点。

```java
package linkedlist;

import common.ListNode;

public class 链表中倒数第k个结点 {
    /**
     * 自想1：
     * 先数个数n，倒数第k个即正数第n-k+1个
     * 注意考虑k>n的情况
     * 时间复杂度O(n)，需要遍历两次链表，空间复杂度O(1)
     */
    public ListNode FindKthToTail1(ListNode head, int k) {
        ListNode cur = head;
        int count = 0;
        while (cur != null) {
            count++;
            cur = cur.next;
        }
        int indexFrom1 = count - k + 1;
        if (indexFrom1 <= 0) {
            return null;
        }
        cur = head;
        for (int i = 2; i <= indexFrom1 && cur != null; i++) {
            cur = cur.next;
        }
        return cur;
    }

    /**
     * 讨论区：
     * 两个指针，区间平移
     * 第一个指针从第k个走到第n个，第二个指针从第1个走到倒数第k个
     * 两个指针，先让第一个指针和第二个指针都指向头结点，然后再让第一个指针走(k-1)步，到达第k个节点。
     * 然后两个指针同时往后移动，当第一个结点到达第n个的时候，第二个结点所在位置就是倒数第k个节点了。
     * 时间复杂度O(n)，只需要遍历一次链表，空间复杂度O(1)
     */
    public ListNode FindKthToTail2(ListNode head, int k) {
        if (head == null || k <= 0) {
            return null;
        }
        ListNode pre = head, cur = head;
        for (int i = 2; i <= k; i++) {
            if (pre.next != null) {
                pre = pre.next;
                // 在从第1个走到第k个的时候就碰到了null，说明k>n，则直接返回null
            } else {
                return null;
            }
        }
        while (pre.next != null) {
            pre = pre.next;
            cur = cur.next;
        }
        return cur;
    }
}
```

