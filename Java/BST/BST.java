
class BST {

	BTNode root;
	
	public BST(){
		root = null;
	}
	public BTNode getRoot(){
		return root;
	}
	public void insert(int val){
		if(root == null)
			root = insert(root, null, val);
		else
			root = insert(root, root.getParent(), val);
	}
	
	public BTNode insert(BTNode target, BTNode parent, int val){
		if(target == null){
			return new BTNode(val, null, null, parent);
		}
		if(target.getData() == val){
			System.out.println(val + " already exists, ignore.");
			return target;
		}
		if(target.getData() < val){
			parent = target;
			target.setRight(insert(target.getRight(), parent, val));
		}
		else{
			parent = target;
			target.setLeft(insert(target.getLeft(), parent, val));
		}
		
		return target;
	}
	
	public void delete(int val) { 
		root = delete(root, val); 
		} 
	private BTNode delete(BTNode node, int val) { 
		if (node == null) {
			System.out.println(val + " does not exist!");
			return null;
		}
		else if (node.getData() < val) 
			node.setRight(delete(node.getRight(), val));
		else if (node.getData() > val) 
			node.setLeft(delete(node.getLeft(), val)); 
		else { 
			if (node.getLeft() == null) 
				return node.getRight(); 
			else if (node.getRight() == null) 
				return node.getLeft(); 
			else { 
				// get data from the rightmost node in the left subtree 
				node.setData(node.getLeft().getRightmostData()); 
				// delete the rightmost node in the left subtree 
				node.setLeft(delete(node.getLeft(), node.getData())); 
			} 
		} 
		return node; 
	} 

	public BTNode predecessor(BTNode node){
        if (node == null)
            return null;
       
        if (node.getLeft() != null)
            return node.getRightmost(node.getLeft());
               
        BTNode y = node.getParent();
        BTNode x = node;
        while (y != null && x == y.getLeft())
        {
            x = y;
            y = y.getParent();
        }
       
        return y;
    }
	public BTNode successor(BTNode node)
    {
        if (node == null)
            return null;
       
        if (node.getRight() != null)
            return node.getLeftmost(node.getRight());
       
        BTNode y = node.getParent();
        BTNode x = node;
        while (y != null && x == y.getRight())
        {
            x = y;
            y = y.getParent();
        }
        return y;
    }
	public BTNode getNode(BTNode node, int val){
		if(node == null){
			System.out.println(val + " does not exist in the tree!");
			return node;
		}
		else if(node.getData() == val)
			return node;
		else if(node.getData() < val)
			return getNode(node.getRight(), val);
		else
			return getNode(node.getLeft(), val);
	}

}

