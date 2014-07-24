import java.util.Random;
class Heap {
	public static final int HEAP_ARRAY_SIZE = 100;
	private int heapArray[];
	private int heapSize;
	private int numSwaps;
	
	//root index = 0
	//parent index = floor((i - 1)/2)
	//child left index = 2i + 1
	// NOTE: always odd
	//child right index = 2i + 2
	// NOTE: always even
	//height = log(n)
	
	//Worst case complexity
	//Sequential insertion = O(nlogn), 100log(100) = 664
	//Optimum insertion = O(n), 100
	
	public Heap(){
		heapArray = new int[HEAP_ARRAY_SIZE];
		heapSize = 0;
		numSwaps = 0;
	}
	//Display first ten value in heapArray
	public void Display(){
		for(int i = 0; i < 10; ++i){
			System.out.print(heapArray[i] + " ");
		}
		System.out.println();
	}
	//checks if a value is already in the heap
	public boolean isInHeap(int val){
		for(int i = 0; i < heapSize; ++i){
			if(val == heapArray[i])
				return true;
		}
		return false;
	}
	//Combine sequential and optimum insertion in order to use same random integers
	public void RandSeqOptInit(){
		Random rand = new Random();
		int randInt = -1;
		int tempArray[] = new int[HEAP_ARRAY_SIZE];
		boolean flag = true;
		int swapAccum1 = 0;
		int swapAccum2 = 0;
		
		//create 20 sets of random integers
		for(int i = 0; i < 20; ++i){
			//insert in sequential order
			for(int j = 0; j < HEAP_ARRAY_SIZE; ++j){
				flag = true;
				while(flag){
					randInt = rand.nextInt(2147483646) + 1;//Range(0 to 2^31 - 2) + 1
					if(isInHeap(randInt))//inefficient
						flag = true;
					else 
						flag = false;
				}
				Insert(randInt);
				++heapSize;
				tempArray[j] = randInt;
			}
			swapAccum1 += numSwaps;
			//reset heap
			heapSize = 0;
			numSwaps = 0;
			//insert same numbers using optimum insertion
			for(int j = 0; j < HEAP_ARRAY_SIZE; ++j){
				heapArray[j] = tempArray[j];
				++heapSize;
			}
			//optimum swap starting at last element
			OptSwap(heapSize - 1);
			swapAccum2 += numSwaps;
			//reset heap
			heapSize = 0;
			numSwaps = 0;
		}
		System.out.println("The average number of swaps for random sequential insertion = " + (swapAccum1 / 20));
		System.out.println("The average number of swaps for random optimum insertion = " + (swapAccum2 / 20));
	}
	//insert ordered integer into a heap sequentially
	public void OrdSeqInit(){
		for(int i = 0; i < HEAP_ARRAY_SIZE; ++i){
			Insert(i + 1);
			++heapSize;
		}
		System.out.println("The number of swaps for ordered sequential insertion = " + numSwaps);
		Display();
		for(int i = 0; i < 10; ++i){
			Delete();
		}
		System.out.println("Delete 10:");
		Display();
		//reset heap
		heapSize = 0;
		numSwaps = 0;
	}
	//insert ordered integer into a heap optimally
	public void OrdOptInit(){
		for(int i = 0; i < HEAP_ARRAY_SIZE; ++i){
			heapArray[i] = i + 1;
			++heapSize;
		}
		//optimum swap starting at last element
		OptSwap(heapSize - 1);
		System.out.println("The number of swaps for ordered optimum insertion = " + numSwaps);
		Display();
		System.out.println("Delete 10:");
		for(int i = 0; i < 10; ++i){
			Delete();
		}
		Display();
		heapSize = 0;
		numSwaps = 0;
	}
	public void OptSwap(int index){
		if(index < 0)
			return;
		else if((index - 1) / 2 < 0)
			return;
		else{
			//Swap parent down
			SwapDown((index - 1) / 2);
			//OptSwap on next child pair
			OptSwap(index - 2);
		}
	}
	//insert after last existing element
	public void Insert(int val){
		if(heapSize == HEAP_ARRAY_SIZE)
			System.out.println("Heap is full, cannot insert");
		else{
			heapArray[heapSize] = val;
			SwapUp(heapSize);
		}
	}
	//replace root with last existing element
	public int Delete(){
		int temp;
		if(heapSize == 0){
			System.out.println("Heap is empty, cannot delete");
			return -1;
		}
		else if(heapSize == 1){
			temp = heapArray[0];
			--heapSize;
			return temp;
		}
		else{
			temp = heapArray[0];
			heapArray[0] = heapArray[heapSize - 1];
			--heapSize;
			SwapDown(0);
			return temp;
		}
	}
	public void SwapUp(int index){
		int temp;
		//no parent
		if(((index - 1)/2) < 0)
			return;
		//child > parent, swap with parent
		else if(heapArray[index] > heapArray[(index - 1) / 2]){
			temp = heapArray[(index - 1) / 2];
			heapArray[(index - 1) / 2] = heapArray[index];
			heapArray[index] = temp;
			++numSwaps;
			SwapUp((index - 1) / 2);
		}
	}
	public void SwapDown(int index){
		int temp;
		//since heap are complete if a node doesn't have a left child it has 
		//no children
		if(((2 * index) + 1) > heapSize - 1)
			return;
		//if a node only has a left child
		else if(((2 * index) + 2) > heapSize - 1){
			//left > parent, swap with parent
			if(heapArray[(2 * index) + 1] > heapArray[index]){
				temp = heapArray[index];
				heapArray[index] = heapArray[(2 * index) + 1];
				heapArray[(2 * index) + 1] = temp;
				++numSwaps;
				SwapDown((2 * index) + 1);
			}
		}
		//if a node has 2 children
		else{
			//left > parent and left > right, swap with parent
			if(heapArray[(2 * index) + 1] > heapArray[index] && 
			   heapArray[(2 * index) + 1] > heapArray[(2 * index) + 2]){
				temp = heapArray[index];
				heapArray[index] = heapArray[(2 * index) + 1];
				heapArray[(2 * index) + 1] = temp;
				++numSwaps;
				SwapDown((2 * index) + 1);
			}
			//right > parent and right > left, swap with parent
			else if(heapArray[(2 * index) + 2] > heapArray[index]){
				temp = heapArray[index];
				heapArray[index] = heapArray[(2 * index) + 2];
				heapArray[(2 * index) + 2] = temp;
				++numSwaps;
				SwapDown((2 * index) + 2);
			}
		}
	}
}
