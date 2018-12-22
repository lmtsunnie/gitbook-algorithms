![](http://qiniu.limengting.site/mac11.jpg)

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

import static format.PrintBinaryTree.*;

public class leetcode105ConstructBinaryTreeFromPreorderAndInorderTraversal {
    /*思路自己想的，但是实现有一些问题：
    * preOrder[0]是root，然后在inOrder里面找到preOrder[0]，例如是inOrder[1]
    * 则inOrder[1]的左边inOrder[0]是左子树，inOrder[1]的右边inOrder[2]-inOrder[4]是右子树
    * 递归可以构造出一颗树
    * */
    public static Node buildTree(int[] preOrder, int[] inOrder) {
        return helper(0, 0, inOrder.length - 1, preOrder, inOrder);
    }

    public static Node helper(int preStart, int inStart, int inEnd, int[] preOrder, int[] inOrder) {
        if (preStart > preOrder.length - 1 || inStart > inEnd) {
            return null;
        }
        Node root = new Node(preOrder[preStart]);
        int inRootIndex = 0;
        for (int i = inStart; i <= inEnd; i ++) {
            if (inOrder[i] == root.value) {
                inRootIndex = i;
            }
        }
        root.left = helper(preStart + 1, inStart, inRootIndex - 1, preOrder, inOrder);
        root.right = helper(preStart + inRootIndex - inStart + 1, inRootIndex + 1, inEnd, preOrder, inOrder);
        return root;
    }

    public static void main(String[] args) {
        int[] preOrder = new int[]{3,9,20,15,7};
        int[] inOrder = new int[]{9,3,15,20,7};
        printTree(buildTree(preOrder, inOrder));
    }
}
```

