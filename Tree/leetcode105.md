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
package array;

import common.TreeNode;

public class leetcode105ConstructBinaryTreeFromPreorderAndInorderTraversal {
    
/**
     * 自想：二分的思路，先序分成[根|左|右]，中序分成[左|根|右]，根在先序一定是preorder[0]，找到根在中序中inorder[inRoot]
     * 左右子树各分别二分，递归到超出范围则向上返回
     * 在先序中，根是preStart，左子树是[preStart + 1, preStart + 1 + leftLength - 1]，右子树是[preStart + leftLength + 1, preEnd]
     * 在中序中，左子树是[inStart, inRoot - 1]，根是inRoot，右子树是[inRoot + 1, inEnd]
     * 所以左子树的总节点个数leftLength = inRoot - 1 - inStart + 1 = inRoot - inStart
     * 所以先序中左子树是[preStart + 1, preStart + inRoot - inStart]，右子树是[preStart + inRoot - inStart + 1, preEnd]
     * T(n) = 2T(n/2) + O(n)，时间复杂度nlogn
     * @param preorder
     * @param inorder
     * @return
     */
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        if (preorder == null || inorder == null || preorder.length <= 0 || preorder.length != inorder.length) {
            return null;
        }
        return helper(preorder, inorder, 0, preorder.length - 1, 0, inorder.length - 1);
    }
    public TreeNode helper(int[] preorder, int[] inorder, int preStart, int preEnd, int inStart, int inEnd) {
        if (preStart > preEnd || inStart > inEnd) {
            return null;
        }
        TreeNode root = new TreeNode(preorder[preStart]);
        int inRoot = inStart;
        for (int i = inStart; i <= inEnd; i ++) {
            if (inorder[i] == root.val) {
                inRoot = i;
                break;
            }
        }
        root.left = helper(preorder, inorder, preStart + 1, preStart + inRoot - inStart, inStart, inRoot - 1);
        root.right = helper(preorder, inorder, preStart + inRoot - inStart + 1, preEnd, inRoot + 1, inEnd);
        return root;
    }
}
```

