//Tzamtzis Marios 10038 6949214612 tzamtzis@ece.auth.gr
//Tsipis Pantelis 10224 6947548593 panttsip@ece.auth.gr

import java.util.Random;

public class Board {
	//Variables
	int N;//the dimensions of the NxN board
	int S;//The number of the supplies on the board
	int W;//The number of the walls on the board
	Tile[] tiles;//a Tile-type array
	Supply[] supplies;//a supply-type array
	
	//Default constructor
	public Board() {
		N = 0;
		S = 0;
		W = 0;
	}
	
	//Constructor with the arguments
	public Board(int N, int S, int W) {
		this.N = N;
		this.S = S;
		this.W = W;
		tiles = new Tile[N*N];
		for(int i=0;i<N*N;i++) {
			tiles[i] = new Tile(i,i/N,i%N,false,false,false,false);//x=i div N, y=i mod N
		}
		supplies = new Supply[S];
	}
	
	//Copy constructor
	public Board(Board board) {
		this.N = board.N;
		this.S = board.S;
		this.W = board.W;
		for(int i=0; i<N*N; i++) 
			this.tiles[i] = board.tiles[i];
		for(int i=0; i<S;i++) {
			this.supplies[i] = board.supplies[i];
		}
	}
	
	//Setters and getters of all the variables
	public void setN(int N) {
		this.N = N;
	}
	
	public void setS(int S) {
		this.S = S;
	}
	
	public void setW(int W) {
		this.W = W;
	}
	
	public void setTiles(Tile[] tiles) {
		for(int i = 0; i<N*N; i++)
			this.tiles[i] = tiles[i];
	}
	
	public void setSupplies(Supply[] supplies) {
		for(int i = 0; i<S; i++)
			this.supplies[i] = supplies[i];
	}
	
	public int getN() {
		return N;
	}
	
	public int getS() {
		return S;
	}
	
	public int getW() {
		return W;
	}
	
	public Tile[] getTiles() {
		return tiles;
	}
	
	public Supply[] getSupplies() {
		return supplies;
	}
	
	//Initialization of the objects of the Tile-array
	public void createTile() {
		int w = W - (4*N);//subtracting the outer walls which are 4*N
		Random directions = new Random();//Up=0,Down=1,Left=2,Right=3
		Random randomId=new Random();//a random id from 0 to N*N-1
		int direction,randId;
		int temp,temp2;
		
		//setting the two horizontal borders
		for(int i=0;i<N;i++) {
			tiles[i].setDown(true);
			tiles[i+(N*N - N)].setUp(true);
		}
				
		//setting the vertical borders
		for(int j=0;j<N*N;j+=N) {
			tiles[j].setLeft(true);
			tiles[j+N-1].setRight(true);
		}
		
		for (int i = 0; i<w; i++) {
			randId = randomId.nextInt((N*N)); //choosing a random tileId
			direction = directions.nextInt(4);//choosing a random direction
			
			//Checking if we are in the first tile or in the last tile of the first row or in the first tile of the last row or in the last tile. There are already two walls on the tile.
			if(randId==0||randId==N-1||randId==N*N-N||randId==N*N-1)
				continue;
			else {
				temp=0;
				
				//Checking if there are two walls on the tile
				if (tiles[randId].getUp() == true)
					temp++;
				if (tiles[randId].getDown() == true)
					temp++;
				if (tiles[randId].getLeft() == true)
					temp++;
				if (tiles[randId].getRight() == true)
					temp++;
				
				if(temp==2)
					continue;
				
				//Checking if it is randomly selected to put a wall on the up
				if (direction == 0) {
					//Checking if we are in the last row where the up is already true
					if (randId > N*N-N) 
						continue;
					//Checking if the above tile has the down true
					else if (tiles[randId + N].getDown() == true) {
						tiles[randId].setUp(true);//We set the up true
						continue;
					}
					else {
						
						temp2 = 0;
						//Checking if the above tile has two walls
						if (tiles[randId + N].getUp() == true) 
							temp2++;
						if (tiles[randId + N].getLeft() == true)
							temp2++;
						if (tiles[randId + N].getRight() == true)
							temp2++;
						if (temp2==2) 
							continue;
						else {
							tiles[randId].setUp(true);	//we set the up true				
							tiles[randId + N].setDown(true);//we set the down true on the above tile
						}
					}
				}
				
				//Checking if it is randomly selected to put a wall on the down
				else if (direction == 1) {
					//Checking if we are in the first row where the down is already true
					if (randId < N-1) 
						continue;
					//Checking if the below tile has the up true
					else if (tiles[randId - N].getUp() == true) {
						tiles[randId].setDown(true);//We set the down true
						continue;
					}
					else {
						
						temp2 = 0;
						//Checking if the below tile has two walls
						if (tiles[randId - N].getDown() == true) 
							temp2++;
						if (tiles[randId - N].getLeft() == true)
							temp2++;
						if (tiles[randId - N].getRight() == true)
							temp2++;
						if (temp2==2) 
							continue;
						else {
							tiles[randId].setDown(true);	//we set the down true				
							tiles[randId - N].setUp(true);//we set the up true on the below tile
						}
					}
				}
				
				//Checking if it is randomly selected to put a wall on the left
				else if (direction == 2) {
					//Checking if we are in the first column where the left is already true
					if ((randId%N) == 0) 
						continue;
					//Checking if the previous tile has the right true
					else if (tiles[randId - 1].getRight() == true) {
						tiles[randId].setLeft(true);//We set the left true
						continue;
					}
					else {
						
						temp2 = 0;
						//Checking if the previous tile has two walls
						if (tiles[randId - 1].getUp() == true) 
							temp2++;
						if (tiles[randId - 1].getDown() == true)
							temp2++;
						if (tiles[randId - 1].getLeft() == true)
							temp2++;
						if (temp2==2) 
							continue;
						else {
							tiles[randId].setLeft(true);	//we set the left true				
							tiles[randId - 1].setRight(true);//we set the right true on the previous tile
						}
					}
				}
				
				//Checking if it is randomly selected to put a wall on the right
				else if (direction == 3) {
					//Checking if we are in the last column where the right is already true
					if ((randId%N) == (N-1)) 
						continue;
					//Checking if the next tile has the left true
					else if (tiles[randId + 1].getLeft() == true) {
						tiles[randId].setRight(true);//We set the right true
						continue;
					}
					else {
						
						temp2 = 0;
						//Checking if the next tile has two walls
						if (tiles[randId + 1].getUp() == true) 
							temp2++;
						if (tiles[randId + 1].getDown() == true)
							temp2++;
						if (tiles[randId + 1].getRight() == true)
							temp2++;
						if (temp2==2) 
							continue;
						else {
							tiles[randId].setRight(true);	//we set the right true				
							tiles[randId + 1].setLeft(true);//we set the left true on the next tile
						}
					}
				}
				
				
			}
			
		}
			
				
		
	}
	
		
	
	//Initialization of the objects in the Supply-array
	public void createSupply() {
		int [] counter=new int [S];//the random-numbers array
		Random rand=new Random();
		int j;
	for(int i=0;i<S;i++){
	    counter[i]=rand.nextInt(N*N-1)+1;//we put S random numbers from 1 to N*N-1
	    j=0;
	    while(true){
	        //excluding the tile of the minotaur
	        if(counter[i]==N*N/2){
	            counter[i]= rand.nextInt(N*N-1)+1;
	            continue;
	        }
	        //Checking if we have already checked that this element is different from the other elements of the counter[]
	        if(i==j)
	        	break;
	        //Checking if the two elements are not equal
	        if(counter[i]!=counter[j]){
	            j++;
	            continue;
	            }
	        //If the two elements are equal
	        else {
		        counter[i]=rand.nextInt(N*N-1)+1;
		        j=0;//in order to start the check from the beginning
	        }
	        }
	        
	    }
		//constructing the Supply-array
	    for(int i=0;i<S;i++){
	        int x=counter[i]/N;//x=supplyTileId div N
	        int y=counter[i]%N;//y=supplyTileId mod N
	        supplies[i]=new Supply(i+1,x,y,counter[i]);
	    }
	}
	
	//Creating the board of the game
	public void createBoard() {
		createTile();
		createSupply();
	}
	
	//Creates and returns the (2*N+1)*N array
	String [][] getStringRepresentation(int theseusTile, int minotaurTile){

		String [][] array =new String [2*N+1][N];
		String temp;
		int tempsupply;
		
		//In the rows of the array, that are odd numbers, we put horizontal walls or "horizontal" gaps, 
		//while in the rows of the array, that are even numbers, we put vertival walls or "vertical" gaps or the symbol of supplies or the symbol of Theseus or the symbol of Minotaur
		
		//Building the array for the last row of the board
		for(int j=0;j<N;j++) {
			//if we are in the last tile of the last row
			if(j==N-1) {
				if(tiles[N*N-N+j].getUp()==true){
					array[0][j]="+---+";
				}
				else {
					array[0][j]="+   +";
				}
			}
			//If we are in the last row except for the last tile
			else {
				if(tiles[N*N-N+j].getUp()==true) {
					array[0][j]="+---";
				}
				else {
					array[0][j]="+   ";
				}
			}
		}
				
		for(int i=0;i<N;i++) {
			for(int j=0;j<N;j++) {
				tempsupply=-1;//getting ready the variable tempsupply for the next time that we use it
				//If the tile has a down wall
				if(tiles[i*N+j].getDown()==true) {
					//if the tile is in the last column
					if(j==N-1) {                         
						array[2*(N-i)][j]="+---+";
					}
					else {
						array[2*(N-i)][j]="+---";
					}
				}
				//If the tile does not have a down wall
				else {
						if(j==N-1) {
							array[2*(N-i)][j]="+   +";
						}
						else {
							array[2*(N-i)][j]="+   ";
						}
					}
				
				//end of the implementation of the rows with odd numbers
				
				//The beginning of the implementation of the rows with even numbers
					//If the tile is in the last column
					if(j==N-1) {  
						//if there is a wall on the left
						if(tiles[i*N+j].getLeft()==true) {
							temp="|";
						}
						else {
							temp=" ";//leaves a gap
						}
						//we put the suitable value to the tempsupply
						for(int counter=0;counter<S;counter++) { 
							if(tiles[i*N+j].getTileId()==supplies[counter].getSupplyTileId()) {
								tempsupply=counter;
								break;
							}
						}
						//Checking if both Minotaur and a supply are on the tile
						if(tiles[i*N+j].getTileId()==minotaurTile&&tempsupply>=0) {
							temp=temp+"MS"+(tempsupply+1);
						}
						//Checking if Minotaur is on the tile
						else if(tiles[i*N+j].getTileId()==minotaurTile) {
							temp=temp+" M ";
						}
						//Checking if Theseus is on the tile
						else if(tiles[i*N+j].getTileId()==theseusTile) {
							temp=temp+" T ";
						}
						//Checking if there is a supply on the tile
						else if(tempsupply>=0) {
							temp=temp+" S"+(tempsupply+1);
						}
						//if the tile is empty
						else {
							temp=temp+"   ";
						}
						temp=temp+"|";//since we are in the last column we put a right vertical wall
						array[2*(N-i)-1][j]=temp;//we put temp in the array
							
					}
					//If the tile is not in the last column we follow the same algorithm except for the command temp=temp+"|" because we are not in the last column
					else {
						//Checking if there is a wall on the left
						if(tiles[i*N+j].getLeft()==true) {
						temp="|";
						}
						else {
							temp=" ";//leaves a gap
						}
						//we put the suitable value to the tempsupply
						for(int counter=0;counter<S;counter++) {                     
							if(tiles[i*N+j].getTileId()==supplies[counter].getSupplyTileId()) {
								tempsupply=counter;
								break;
							}
						}
						//Checking if both Minotaur and a supply are on the tile
						if(tiles[i*N+j].getTileId()==minotaurTile&&tempsupply>=0) {
							temp=temp+"MS"+(tempsupply+1);
						}
						//Checking if Minotaur is on the tile
						else if(tiles[i*N+j].getTileId()==minotaurTile) {
							temp=temp+" M ";
						}
						//Checking if Theseus is on the tile
						else if(tiles[i*N+j].getTileId()==theseusTile) {
							temp=temp+" T ";
						}
						//Checking if there is a supply on the tile
						else if(tempsupply>=0) {
							temp=temp+" S"+(tempsupply+1);
						}
						//if the tile is empty
						else {
							temp=temp+"   ";
						}
						array[2*(N-i)-1][j]=temp;//we put temp in the array
					}
							
		}
		}
		
		//Checking if we are in the initial situation
		if(theseusTile==0&&minotaurTile==((N*N)/2))
			array[2*N][0] = "+   ";//the down wall of the first tile is open
				
		
	return array;			
	
	}

}
	