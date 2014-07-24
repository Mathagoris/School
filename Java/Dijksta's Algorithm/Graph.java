
public class Graph {
	final static int NUM_CITIES = 20;
    private int[][] edges; // edges[i][j] is true if there is a vertex from i to j
    private City[] labels; // labels[i] contains the label for vertex i

    // Constructor: initialize a Graph with n vertices, no edges, and null labels
	public Graph(int n) {
        edges = new int[n][n]; // All values initially false
        labels = new City[n]; // All values initially null
    }

    // Add an edge
    public void addEdge(int source, int target, int value) {
        edges[source][target] = value;
    }

    // Accessor method to get the label of a vertex of this Graph
    public City getLabel(int vertex) {
        return labels[vertex];
    }
    
    // Returns the full name of a label at a certain vertex
    public String getLabelName(int vertex) {
    	return labels[vertex].fullName;
    }
    
    //Accessor method to get the mileage between cities
    public int getEdge(int source, int target){
    	return edges[source][target];
    }

    // Test whether an edge exists
    // could make it so that if source == target returns true but it is not technically an edge
    public boolean isEdge(int source, int target) {
        return (edges[source][target] > 0);
    }

    // Obtain a list of neighbors of a specified vertex of this Graph
    public int[] neighbors(int vertex) {
        int i;
        int count = 0;
        int[] answer;

        for (i = 0; i < labels.length; i++) {
            if (isEdge(vertex, i))
                count++;
        }
        answer = new int[count];
        count = 0;
        for (i = 0; i < labels.length; i++) {
            if (isEdge(vertex, i))
                answer[count++] = i;
        }
        return answer;
    }

    // Remove an edge
    public void removeEdge(int source, int target) {
        edges[source][target] = 0;
    }

    // Change the label of a vertex of this Graph
    public void setLabel(int vertex, City newLabel) {
        labels[vertex] = newLabel;
    }

    // Accessor method to determine the number of vertices in this Graph
    public int size() {
        return labels.length;
    }
    
    // Search for a label and return the index if it is in the labels array
    public int findLabel(String abbr){
    	for(int i = 0; i < NUM_CITIES; ++i){
    		if(labels[i].abbrName.compareTo( abbr.toUpperCase()) == 0){
    			return i;
    		}
    	}
    	return -1;
    }
    
    // Print out all the elements of a label
    public void printLabel(int vertex){
    	System.out.println((vertex + 1) + " " + labels[vertex].abbrName + " " + labels[vertex].fullName + " " +
    					   labels[vertex].population + " " + labels[vertex].elevation);
    }
    
    // Find the shortest distance from an element to all other elements
    public int[] shortestPath(int source, int target){
    	int[] dist = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}; // initialized as -1 to simulate infinity
    	int[] previous = new int[NUM_CITIES];
    	int[] neighbors;
    	boolean[] visited = new boolean[NUM_CITIES];
    	int u = source;
    	int alt;
    	int shortest = -1;
    	dist[source] = 0;
    	
    	while(u != -1){
    		if(dist[u] == -1){
    			break;
    		}
    		// mark the u element visited
    		visited[u] = true;
    		// get u's neighbors
    		neighbors = neighbors(u);
    		for(int i = 0; i < neighbors.length; ++i){
    			if(!visited[neighbors[i]]){
    				// alt = dist[u] + dist(u,v)
    				alt = dist[u] + getEdge(u, neighbors[i]);
    				if(dist[neighbors[i]] == -1){ // dist[v] = infinity
    					dist[neighbors[i]] = alt;
    					previous[neighbors[i]] = u;
    				}
    				else if(alt < dist[neighbors[i]]){ // alt < dist [v]
    					dist[neighbors[i]] = alt;
    					previous[neighbors[i]] = u;
    				}
    			}
    		}
    		shortest = -1;
    		// determine next u element
    		for(int i = 0; i < dist.length; ++i){
    			if(!visited[i] && dist[i] != -1){
    				if(shortest == -1)
    					shortest = i;
    				else if (dist[i] < dist[shortest])
    					shortest = i;
    			}
    		}
    		u = shortest;
    		if(u == target)
    			return previous;
    	}
    	return null;
    }
    
    
    // Calculate the distance from source to target city using path
    public int pathDistance(int[] path, int source, int target){
    	int tempDistance = 0;
    	while(target != source){
    		tempDistance += getEdge(path[target], target);
    		target = path[target];
    	}
    	return tempDistance;
    }
    
    // Print the path from source to target city
    public void printPath(int[] path, int source, int target){
    	int[] revPath = new int[path.length];
    	int i = 0;
    	
    	System.out.print(labels[source].abbrName);
    	for(int temp = target; source != temp; ++i, temp = path[temp]){
    		revPath[i] = temp;
    	}
    	--i;
    	for(; i >= 0; --i){
    		System.out.print(", " + labels[revPath[i]].abbrName);
    	}
    	System.out.println();
    }
}