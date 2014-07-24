import java.util.Scanner;
import java.io.*;

public class Project3 {
	final static int NUM_CITIES = 20;
	public static void main(String[] args) {
		String response;
		int vertex1;
		int vertex2;
		int distance;
		int[] path;
		Graph myGraph = new Graph(NUM_CITIES);
		
		InitializeGraph(myGraph);
		Scanner kb = new Scanner(System.in);
		while(true){
			System.out.print("Command? ");
			response = kb.next();
			
			switch(response.toUpperCase()){
			case "Q":
				// Query a city
				System.out.print("City code: ");
				response = kb.next();
				vertex1 = myGraph.findLabel(response);
				if(vertex1 != -1){
					myGraph.printLabel(vertex1);
				}
				else
					System.out.println("City not found.");
				break;
			case "D":
				// Find the shortest path from one city to another
				System.out.print("City codes: ");
				response = kb.next();
				
				// Find the index that source city is located at
				vertex1 = myGraph.findLabel(response);
				if(vertex1 != -1){
					response = kb.next();
					
					//Find the index that target city is located at
					vertex2 = myGraph.findLabel(response);
					if(vertex2 != -1){
						if(vertex1 == vertex2){
							System.out.println("The cities entered are the same, therefore the path cost is 0.");
							break;
						}
						// Get the shortest path
						path = myGraph.shortestPath(vertex1, vertex2);
						if(path != null){
							// evaluate distance between cities and print the path out
							distance = myGraph.pathDistance(path, vertex1, vertex2);
							System.out.print("The minimum distance between " + myGraph.getLabelName(vertex1) +
											   " and " + myGraph.getLabelName(vertex2) + " is " + distance +
											   " through the route: ");
							myGraph.printPath(path, vertex1, vertex2);
						}
						else
							System.out.println("A path from " + myGraph.getLabelName(vertex1) + " to " +
												myGraph.getLabelName(vertex2) + " doesn't exist.");
					}
					else
						System.out.println("One or more of the city codes does not exist.");
				}
				else
					System.out.println("One or more of the city codes does not exist.");
				break;
			case "I":
				// Insert a road
				System.out.print("City codes and distance: ");
				response = kb.next();
				
				// Find index of source city
				vertex1 = myGraph.findLabel(response);
				if(vertex1 != -1){
					response = kb.next();
					
					// Find index of target city
					vertex2 = myGraph.findLabel(response);
					if(vertex2 != -1){
						distance = kb.nextInt();
						
						// Make sure there is not already an existing edge and insert it
						if(!myGraph.isEdge(vertex1, vertex2)){
							myGraph.addEdge(vertex1, vertex2, distance);
							System.out.println("You have inserted a road between " + myGraph.getLabelName(vertex1) +
												" and " + myGraph.getLabelName(vertex2) + " with a distance of " +
												distance + ".");
						}
						else
							System.out.println("The road from " + myGraph.getLabelName(vertex1) + " to " +
												myGraph.getLabelName(vertex2) + " already exists.");
					}
					else
						System.out.println("One or more of the city codes does not exist.");
				}
				else
					System.out.println("One or more of the city codes does not exist.");
				break;
			case "R":
				System.out.print("City codes: ");
				response = kb.next();
				
				// Find the index of the source city
				vertex1 = myGraph.findLabel(response);
				if(vertex1 != -1){
					response = kb.next();
					
					// Find the index of the target city
					vertex2 = myGraph.findLabel(response);
					if(vertex2 != -1){
						
						// Make sure there is an edge and delete it
						if(myGraph.isEdge(vertex1, vertex2)){
							myGraph.removeEdge(vertex1, vertex2);
							System.out.println("The road from " + myGraph.getLabelName(vertex1) + " to " +
									myGraph.getLabelName(vertex2) + " was removed.");
						}
						else
							System.out.println("The road from " + myGraph.getLabelName(vertex1) + " to " +
									myGraph.getLabelName(vertex2) + " doesn't exist.");
					}
					else
						System.out.println("One or more of the city codes does not exist.");
				}
				else
					System.out.println("One or more of the city codes does not exist.");
				break;
			case "H":
				PrintMenu();
				break;
			case "E":
				// Exit
				kb.close();
				System.exit(0);
				break;
			default:
				break;
			}
			
		}
	}
	
	// Print out a menu for the user
	public static void PrintMenu(){
		System.out.println(" Q   Query the city information by entering the city code.\n" +
						   " D   Find the minimum distance between two cities.\n" +
						   " I   Insert a road by entering two city codes and distance.\n" +
						   " R   Remove an existing road by entering two city codes.\n" +
						   " H   Display this message.\n" +
						   " E   Exit.");
	}
	
	// Initialize the graph with the city and road data files
	public static void InitializeGraph(Graph myGraph){
		
		File file1 = new File("city.dat");
		File file2 = new File("road.dat");
		
		try{
			Scanner inFile = new Scanner(file1);

			for(int i = 0; i < NUM_CITIES; ++i){
				City newCity = new City();
				inFile.useDelimiter("[ ]+");
				
				// Skip first line element because can just use index
				inFile.nextInt();
				
				// Grab abbreviated and full name
				newCity.abbrName = inFile.next();
				newCity.fullName = inFile.next();
				
				// Check if the full name is more than one word
				while(!inFile.hasNextInt()){
					newCity.fullName += " " + inFile.next();
				}
				// Get weird error if scanner delimiter is not reset
				inFile.reset();
				
				// Get population and elevation
				newCity.population = inFile.nextInt();
				newCity.elevation = inFile.nextInt();
				inFile.nextLine();
				
				// Set the element in the graph
				myGraph.setLabel(i, newCity);
			}
			inFile.close();
		}
		catch (FileNotFoundException e){
			System.out.println("Error: File not found");
		}
		try{
			Scanner inFile = new Scanner(file2);
			int source;
			int target;
			int distance;
			
			// Get edge info from file and insert it into the graph
			while(inFile.hasNextInt()){
				source = inFile.nextInt();
				target = inFile.nextInt();
				distance = inFile.nextInt();
				myGraph.addEdge(source - 1, target - 1, distance);
			}
			inFile.close();
		}
		catch (FileNotFoundException e){
			System.out.println("Error: File not found");
		}
	}

}
