
class BTNode 
{
	private int data;
	private BTNode left;
	private BTNode right;
	private BTNode parent;
	
	// The constructor
	public BTNode (int initialData, BTNode initialLeft, BTNode initialRight
			       , BTNode initialParent)
	{
	  data = initialData;
	  left = initialLeft;
	  right = initialRight;
	  parent = initialParent;
	}
	
	public BTNode getParent(){
		return parent;
	}
	// Getting and Setting Data Links
	public int getData(){
		return data;
	}
	public BTNode getLeft(){
		return left;
	}
	public BTNode getRight(){
		return right;
	}
	public void setData(int newData){
		data = newData;
	}
	public void setLeft(BTNode newLeft){
		left = newLeft;
	}
	public void setRight(BTNode newRight){
		right = newRight;
	}
	public void setParent(BTNode newParent){
		parent = newParent;
	}
	public void inOrder(){
		if (left != null)
			left.inOrder();
		System.out.print(data + " ");
		if (right != null)
			right.inOrder();
	}
	public void preOrder(){
		System.out.print(data + " ");
		if (left != null)
			left.preOrder();
		if (right != null)
			right.preOrder();
	}
	public void postOrder(){
		if (left != null)
			left.postOrder();
		if (right != null)
			right.postOrder();
		System.out.print(data + " ");
	}
	// Testing whether a node is a leaf
	public boolean isLeaf(){
		return (left == null) && (right == null);
	}

	// Getting data from the leftmost or rightmost node; hints: using recursion
	public int getLeftmostData(){
		if(left == null)
			return data;
		else
			return left.getLeftmostData();
	}
	public BTNode getLeftmost(BTNode node){
		if(node.getLeft() == null)
			return node;
		else
			return getLeftmost(node.getLeft());
	}
	public int getRightmostData(){
		if(right == null)
			return data;
		else
			return right.getRightmostData();
	}
	public BTNode getRightmost(BTNode node){
		if(node.getRight() == null)
			return node;
		else
			return getRightmost(node.getRight());
	}

	// Removing the leftmost or rightmost node
	// Remove the leftmost node of the tree with this node as its root.
	// Postcondition: leftmost node removed. The return value is a reference to
	// the root of the new tree. Return value could be null.
	public BTNode removeLeftmost(){
		// the node that activates removeLeftmost has no left child, thus is 
		// itself the leftmost node of the subtree
		if (left == null) {
			return right;
		} else {
		    // a recursive call removes the leftmost node from my left subtree
		    left = left.removeLeftmost();
		    return this;
		}
	}

	// Your turn to implement removeRightmost()
	public BTNode removeRightmost(){
		if (right == null) {
			return left;
		} else {
		    // a recursive call removes the rightmost node from my right subtree
		    right = right.removeLeftmost();
		    return this;
		}
	}

	// the following methods are part of the binary tree class
	// Copying the entire tree
	/*public static  BTNode treeCopy(BTNode source)
	{
		BTNode leftCopy, rightCopy, parentCopy;

		if (source == null)
			return null;
		else {
		    leftCopy = treeCopy(source.getLeft());
		    rightCopy = treeCopy(source.getRight());
		    return new BTNode(source.getData(), leftCopy, rightCopy);
		}
	}*/

	// Height of a node
	public static int height(BTNode node)
	{
		if (node == null)
			return -1; // it's an empty tree
		else
		    return 1 + Math.max(height(node.getLeft()), height(node.getRight()));
	}

	// Calculate the number of nodes in a subtree starting at this node
	public int treeSize(BTNode node){
		if(node == null)
			return 0;
		else
			return 1 + treeSize(node.getLeft()) + treeSize(node.getRight());
	}
	
	// Calculate the number of leaves in a subtree starting at this node
	public int countLeaves(BTNode node){
		if(node == null)
			return 0;
		else if(node.isLeaf())
			return 1;
		else
			return countLeaves(node.getLeft()) + countLeaves(node.getRight());
	}
    
}
