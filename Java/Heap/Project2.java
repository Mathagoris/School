import java.util.Scanner;
class Project2 {
	
	public static void main(String[] args) {
		
		Scanner kb = new Scanner(System.in);
		Heap myHeap = new Heap();
		String input;

		while(true){
			System.out.println("How would you like to initialize the heap?");
			System.out.println("1. Random integers");
			System.out.println("2. Ordered integers");
			System.out.println("3. Quit");
			input = kb.nextLine();
			if((input.length() == 1) && (input.charAt(0) == '1'))
				myHeap.RandSeqOptInit();
			else if((input.length() == 1) && (input.charAt(0) == '2')){
				myHeap.OrdSeqInit();
				myHeap.OrdOptInit();
			}
			else if((input.length() == 1) && (input.charAt(0) == '3')){
				System.out.println("Goodbye!");
				break;
			}
			else
				System.out.println("Invalid input, try again");
			System.out.println();
		}
	}

}
