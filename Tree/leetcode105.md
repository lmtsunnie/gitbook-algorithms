> Given preorder and inorder traversal of a tree, construct the binary tree.
>
> Note:
> You may assume that duplicates do not exist in the tree.
>
> For example, given
>
> preorder = [3,9,20,15,7]
>
> inorder = [9,3,15,20,7]
>
> Return the following binary tree:
>
>     	3
>        / \
>       9  20
>         /  \
>        15   7

```java
package tree;

import java.util.HashMap;
import java.util.Map;

import static format.PrintBinaryTree.*;

public class leetcode105ConstructBinaryTreeFromPreorderAndInorderTraversal {
    /*思路自己想的，但是实现有一些问题：
    * preOrder[0]是root，然后在inOrder里面找到preOrder[0]，例如是inOrder[1]
    * 则inOrder[1]的左边inOrder[0]是左子树，inOrder[1]的右边inOrder[2]-inOrder[4]是右子树
    * 递归可以构造出一颗树
    * 改进：用HashMap来存储<inOrder[i], i>，空间复杂度O(n)
    * */
    public static Node buildTree(int[] preOrder, int[] inOrder) {
        Map<Integer, Integer> inMap = new HashMap<>();
        for (int i = 0; i < inOrder.length; i ++) {
            inMap.put(inOrder[i], i);
        }
        return helper(0, 0, inOrder.length - 1, preOrder, inOrder, inMap);
    }

    public static Node helper(int preStartIndex, int inStartIndex, int inEndIndex, int[] preOrder, int[] inOrder, Map<Integer, Integer> inMap) {
        if (preStartIndex > preOrder.length - 1 || inStartIndex > inEndIndex) {
            return null;
        }
        Node root = new Node(preOrder[preStartIndex]);
        int inRootIndex = inMap.get(root.value);
        int numsLeft = inRootIndex - inStartIndex;
        root.left = helper(preStartIndex + 1, inStartIndex, inRootIndex - 1, preOrder, inOrder, inMap);
        root.right = helper(preStartIndex + numsLeft + 1, inRootIndex + 1, inEndIndex, preOrder, inOrder, inMap);
        return root;
    }

    public static void main(String[] args) {
        int[] preOrder = new int[]{3,9,20,15,7};
        int[] inOrder = new int[]{9,3,15,20,7};
        printTree(buildTree(preOrder, inOrder));
    }
}
```

