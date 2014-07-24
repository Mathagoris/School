import java.util.Scanner;

public class Project1 {
	
	public static void main(String[] args) {
		
		BST tree = new BST();
		Scanner kb = new Scanner(System.in);
		String command;
		String command2;
		BTNode temp = null;
		int val =  0;
		boolean bFlag = false;
		
//		do{
		System.out.println("Please enter the initial sequence of values:");
		command = kb.nextLine();
		String individual[] = command.split(" ");
//		if(!checkInput(individual))
//			bFlag = true;
//		else{
			for (int i = 0; i < individual.length; i++)
			{
				val = Integer.parseInt(individual[i]);
				tree.insert(val);
				bFlag = true;
			}
//		}
//		}while (bFlag);
		
		//Print tree after initializing
		if(tree.getRoot() == null)
			System.out.println("The tree is empty!");
		else{
			System.out.print("Pre-order: ");
			tree.root.preOrder();
			System.out.print("\nIn-order: ");
			tree.root.inOrder();
			System.out.print("\nPost-order: ");
			tree.root.postOrder();
			System.out.println();
		}
		printMenu();
		
		while(true){
			System.out.print("Command? ");
			command = kb.next();
			
			switch(command.toUpperCase()){
			case "I":
				val = kb.nextInt();
				tree.insert(val);
				System.out.print("In-Order: ");
				if(tree.getRoot() == null)
					System.out.println("The tree is empty!");
				else{
					tree.root.inOrder();
					System.out.println();
				}
				break;
			case "D":
				val = kb.nextInt();
				tree.delete(val);
				System.out.print("In-Order: ");
				if(tree.getRoot() == null)
					System.out.println("The tree is empty!");
				else{
					tree.root.inOrder();
					System.out.println();
				}
				break;
			case "P":
				val = kb.nextInt();
				temp = tree.getNode(tree.root, val);
				if(!(temp == null)){
					temp = tree.predecessor(temp);
					if(temp == null)
						System.out.println("This value doesn't have a predecessor.");
					else
						System.out.println(temp.getData());
				}
				break;
			case "S":
				val = kb.nextInt();
				temp = tree.getNode(tree.root, val);
				if(!(temp == null)){
					temp = tree.successor(temp);
					if(temp == null)
						System.out.println("This value doesn't have a successor.");
					else
						System.out.println(temp.getData());
				}
				break;
			case "E":
				System.out.println("Thank you for using!");
				System.exit(0);
				break;
			case "H":
				printMenu();
				break;
			default:
				break;
			}
			
		}
	}
	public static void printMenu(){
		
		System.out.println("\tI  Insert a value");
		System.out.println("\tD  Delete a value");
		System.out.println("\tP  Find predecessor");
		System.out.println("\tS  Find successor");
		System.out.println("\tE  Exit the Program");
		System.out.println("\tH  Display this message");

	}
//	public static boolean checkInput(String array[]){
//		boolean flag = true;
//		char temp;
//		for(int i = 0; i < array.length; ++i){
//			for(int j = 0; j < array[i].length(); ++j){
//				temp = array[i].charAt(j);
//				if(!Character.isDigit(array[i].charAt(j)))
//					flag = false;
//			}
//		}
//		return flag;
//	}
}
