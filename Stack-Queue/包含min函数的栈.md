> 定义栈的数据结构，请在该类型中实现一个能够得到栈中所含最小元素的min函数（时间复杂度应为O（1））。

```java
package stack_queue;

import java.util.Stack;

public class 包含min函数的栈 {
    /**
     * 自想1：
     * 常规的栈两个，一个data栈用来push/pop常规的数据，
     * 一个min栈用来记录当前最小的数据，min栈的个数始终与min栈的个数保持一致
     * 你push我也push，你pop我也pop
     * 时间复杂度O(1)，空间复杂度O(n)
     */
    private Stack<Integer> dataStack;
    private Stack<Integer> minStack;

    public 包含min函数的栈() {
        dataStack = new Stack<>();
        minStack = new Stack<>();
    }

    public void push(int node) {
        if (minStack.isEmpty() || node <= minStack.peek()) {
            minStack.push(node);
        } else {
            minStack.push(minStack.peek());
        }
        dataStack.push(node);
    }

    public void pop() {
        if (dataStack.isEmpty()) {
            throw new RuntimeException("stack is empty!");
        }
        minStack.pop();
        dataStack.pop();
    }

    public int top() {
        if (dataStack.isEmpty()) {
            throw new RuntimeException("stack is empty!");
        }
        return dataStack.peek();
    }

    public int min() {
        if (minStack.isEmpty()) {
            throw new RuntimeException("stack is empty!");
        }
        return minStack.peek();
    }
}
```

