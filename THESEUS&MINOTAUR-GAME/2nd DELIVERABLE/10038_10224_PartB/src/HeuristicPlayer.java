//Tzamtzis Marios 10038 6949214612 tzamtzis@ece.auth.gr
//Tsipis Pantelis 10224 6947548593 panttsip@ece.auth.gr

import java.util.ArrayList;
import java.util.Random;

public class HeuristicPlayer extends Player{
	ArrayList<Integer[]> path;
	static int up=0;//how many times player moved up
	static int right=0;//how many times player moved right
	static int down=0;//how many times player moved down
	static int left=0;//how many times player moved left
	static int round=1;
	
	public HeuristicPlayer() {
		super();
		path = new ArrayList<Integer[]>();
	}
	
	public HeuristicPlayer(int playerId,String name,Board board,int score,int x,int y,ArrayList<Integer[]> path) {
		super(playerId,name,board,score,x,y);
		this.path = new ArrayList<Integer[]>(path.size());
		for(int i=0;i<path.size();i++) {
			this.path.set(i, path.get(i));
		}
	}
	
	public HeuristicPlayer(HeuristicPlayer player) {
		super(player.playerId,player.name,player.board,player.score,player.x,player.y);
		path = new ArrayList<Integer[]>(player.path.size());
		for(int i=0;i<player.path.size();i++) {
			path.set(i, player.path.get(i));
		}
	}
	
	//Target function
	public double f(double SupplyDist, double OpponentDist) {
		return 0.3*SupplyDist + 0.7*OpponentDist;//It is more important to avoid Minotaur than to collect a supply
	}
	
	//Evaluates the possible move of the player through the target function
	public double evaluate(int currentPos, int dice, int minotaurPos) {
		double supplyDist=0;
		double opponentDist=0;
		int N=board.getN();
		//We want to have the tiles of the board
		Tile[] tiles = new Tile[board.getN()*board.getN()];
		for(int i=0;i<tiles.length;i++) {
			tiles[i]=board.tiles[i];
		}
		//We want to have the supplies' tile ids
		int[] supply = new int[board.getS()];
		for(int i=0;i<supply.length;i++) {
			supply[i]=board.supplies[i].getSupplyTileId();
		}
		
		//If the dice is to go up and there is no up wall
		if(dice==1 && tiles[currentPos].getUp()==false) {
			//Checking if the above tile has a supply
			for(int i=0;i<supply.length;i++) {
				if(currentPos==supply[i]-N) {
					supplyDist=1;//the initial distance is 1 tile
					break;
				}
			}
			//Checking if Minotaur is in the above tile
			if(currentPos==minotaurPos-N)
				opponentDist=-1;//the initial distance is 1 tile
			
			//Checking if the above-above tile has a supply since the above tile does not have an up wall and we have not found a near supply yet
			if(tiles[currentPos+N].getUp()==false&&supplyDist==0) {
				for(int i=0;i<supply.length;i++) {
					if(currentPos==supply[i]-2*N) {
						supplyDist=0.5;//the initial distance is two tiles
						break;
					}
				}
			}
			
			//Checking if Minotaur is in the above-above tile since the above tile does not have an up wall and we have not found a near opponent yet
			if(tiles[currentPos+N].getUp()==false&&opponentDist==0) {
				if(currentPos==minotaurPos-2*N)
					opponentDist=-0.5;//the initial distance is two tiles
			}
			
			//Checking if  the above-above tile exists
			if((currentPos+2*N)<N*N) {
				//Checking if the above tile of the above-above tile has a supply since the above-above tile does not have an up wall and we have not found a near supply yet
				if(tiles[currentPos+N].getUp()==false&&tiles[currentPos+2*N].getUp()==false&&supplyDist==0) {
					for(int i=0;i<supply.length;i++) {
						if(currentPos==supply[i]-3*N) {
							supplyDist=0.25;//the initial distance is three tiles
							break;
						}
					}
				}
				//Checking if Minotaur is in the above tile of above-above tile since the above-above tile does not have an up wall and we have not found a near opponent yet
				if(tiles[currentPos+N].getUp()==false&&tiles[currentPos+2*N].getUp()==false&&opponentDist==0) {
					if(currentPos==minotaurPos-3*N)
						opponentDist=-0.25;//the initial distance is three tiles
				}
			}
			
			
			
		}
		
		//If the dice is to go right and there is no right wall
		else if(dice==3 && tiles[currentPos].getRight()==false) {
					//Checking if the right tile has a supply
					for(int i=0;i<supply.length;i++) {
						if(currentPos==supply[i]-1) {
							supplyDist=1;//the initial distance is 1 tile
							break;
						}
					}
					//Checking if Minotaur is in the right tile
					if(currentPos==minotaurPos-1)
						opponentDist=-1;//the initial distance is 1 tile
					
					//Checking if the right-right tile has a supply since the right tile does not have a right wall and we have not found a near supply yet
					if(tiles[currentPos+1].getRight()==false&&supplyDist==0) {
						for(int i=0;i<supply.length;i++) {
							if(currentPos==supply[i]-2) {
								supplyDist=0.5;//the initial distance is two tiles
								break;
							}
						}
					}
					
					//Checking if Minotaur is in the right-right tile since the right tile does not have a right wall and we have not found a near opponent yet
					if(tiles[currentPos+1].getRight()==false&&opponentDist==0) {
						if(currentPos==minotaurPos-2)
							opponentDist=-0.5;//the initial distance is two tiles
					}
					
					//Checking if  the right-right tile exists(in order to exist the right tile must not be in the last column)
					if((currentPos+1)%N!=N-1) {
						//Checking if the right tile of the right-right tile has a supply since the right-right tile does not have a right wall and we have not found a near supply yet
						if(tiles[currentPos+1].getRight()==false&&tiles[currentPos+2].getRight()==false&&supplyDist==0) {
							for(int i=0;i<supply.length;i++) {
								if(currentPos==supply[i]-3) {
									supplyDist=0.25;//the initial distance is three tiles
									break;
								}
							}
						}
						//Checking if Minotaur is in the right tile of right-right tile since the right-right tile does not have a right wall and we have not found a near opponent yet
						if(tiles[currentPos+1].getRight()==false&&tiles[currentPos+2].getRight()==false&&opponentDist==0) {
							if(currentPos==minotaurPos-3)
								opponentDist=-0.25;//the initial distance is three tiles
						}
					}
					
					
					
				}
		
		//If the dice is to go down and there is no down wall
				else if(dice==5 && tiles[currentPos].getDown()==false) {
							//Checking if the down tile has a supply
							for(int i=0;i<supply.length;i++) {
								if(currentPos==supply[i]+N) {
									supplyDist=1;//the initial distance is 1 tile
									break;
								}
							}
							//Checking if Minotaur is in the down tile
							if(currentPos==minotaurPos+N)
								opponentDist=-1;//the initial distance is 1 tile
							
							//Checking if the down-down tile has a supply since the down tile does not have a down wall and we have not found a near supply yet
							if(tiles[currentPos-N].getDown()==false&&supplyDist==0) {
								for(int i=0;i<supply.length;i++) {
									if(currentPos==supply[i]+2*N) {
										supplyDist=0.5;//the initial distance is two tiles
										break;
									}
								}
							}
							
							//Checking if Minotaur is in the down-down tile since the down tile does not have a down wall and we have not found a near opponent yet
							if(tiles[currentPos-N].getDown()==false&&opponentDist==0) {
								if(currentPos==minotaurPos+2*N)
									opponentDist=-0.5;//the initial distance is two tiles
							}
							
							//Checking if  the down-down tile exists
							if(currentPos-2*N>0) {
								//Checking if the down tile of the down-down tile has a supply since the down-down tile does not have a down wall and we have not found a near supply yet
								if(tiles[currentPos-N].getDown()==false&&tiles[currentPos-2*N].getDown()==false&&supplyDist==0) {
									for(int i=0;i<supply.length;i++) {
										if(currentPos==supply[i]+3*N) {
											supplyDist=0.25;//the initial distance is three tiles
											break;
										}
									}
								}
								//Checking if Minotaur is in the down tile of down-down tile since the down-down tile does not have a down wall and we have not found a near opponent yet
								if(tiles[currentPos-N].getDown()==false&&tiles[currentPos-2*N].getDown()==false&&opponentDist==0) {
									if(currentPos==minotaurPos+3*N)
										opponentDist=-0.25;//the initial distance is three tiles
								}
							}
							
							
							
						}
		
		//If the dice is to go left and there is no left wall
				else if(dice==7 && tiles[currentPos].getLeft()==false) {
							//Checking if the left tile has a supply
							for(int i=0;i<supply.length;i++) {
								if(currentPos==supply[i]+1) {
									supplyDist=1;//the initial distance is 1 tile
									break;
								}
							}
							//Checking if Minotaur is in the left tile
							if(currentPos==minotaurPos+1)
								opponentDist=-1;//the initial distance is 1 tile
							
							//Checking if the left-left tile has a supply since the left tile does not have a left wall and we have not found a near supply yet
							if(tiles[currentPos-1].getLeft()==false&&supplyDist==0) {
								for(int i=0;i<supply.length;i++) {
									if(currentPos==supply[i]+2) {
										supplyDist=0.5;//the initial distance is two tiles
										break;
									}
								}
							}
							
							//Checking if Minotaur is in the left-left tile since the left tile does not have a left wall and we have not found a near opponent yet
							if(tiles[currentPos-1].getLeft()==false&&opponentDist==0) {
								if(currentPos==minotaurPos+2)
									opponentDist=-0.5;//the initial distance is two tiles
							}
							
							//Checking if  the left-left tile exists(in order to exist the left tile must not be in the first column)
							if((currentPos-1)%N!=0) {
								//Checking if the left tile of the left-left tile has a supply since the left-left tile does not have a left wall and we have not found a near supply yet
								if(tiles[currentPos-1].getLeft()==false&&tiles[currentPos-2].getLeft()==false&&supplyDist==0) {
									for(int i=0;i<supply.length;i++) {
										if(currentPos==supply[i]+3) {
											supplyDist=0.25;//the initial distance is three tiles
											break;
										}
									}
								}
								//Checking if Minotaur is in the left tile of left-left tile since the left-left tile does not have a left wall and we have not found a near opponent yet
								if(tiles[currentPos-1].getLeft()==false&&tiles[currentPos-2].getLeft()==false&&opponentDist==0) {
									if(currentPos==minotaurPos+3)
										opponentDist=-0.25;//the initial distance is three tiles
								}
							}
							
							
							
						}
		
		
		
		return f(supplyDist,opponentDist);
	}
	
	//This function returns the distance of the nearest supply
	public int findSupplyDistance(int currentPos) {
		int distance=0;
		int N=board.getN();
		//We want to have the tiles of the board
		Tile[] tiles = new Tile[board.getN()*board.getN()];
		for(int i=0;i<tiles.length;i++) {
			tiles[i]=board.tiles[i];
		}
		//We want to have the supplies' tile ids
		int[] supply = new int[board.getS()];
		for(int i=0;i<supply.length;i++) {
			supply[i]=board.supplies[i].getSupplyTileId();
		}
		
		//If there is no up wall
		if(tiles[currentPos].getUp()==false) {
			//Checking if the above tile has a supply
			for(int i=0;i<supply.length;i++) {
				if(currentPos==supply[i]-N) {
					distance=1;//the  distance is 1 tile
					break;
				}
			}
		}
		
		//If there is no right wall
		if(tiles[currentPos].getRight()==false) {
			//Checking if the right tile has a supply
			for(int i=0;i<supply.length;i++) {
				if(currentPos==supply[i]-1) {
					distance=1;//the  distance is 1 tile
					break;
				}
			}
		}
		
		//If there is no down wall
		if(tiles[currentPos].getDown()==false) {
			//Checking if the down tile has a supply
			for(int i=0;i<supply.length;i++) {
				if(currentPos==supply[i]+N) {
					distance=1;//the  distance is 1 tile
					break;
				}
			}
		}
		
		//If there is no left wall
		if(tiles[currentPos].getLeft()==false) {
			//Checking if the left tile has a supply
			for(int i=0;i<supply.length;i++) {
				if(currentPos==supply[i]+1) {
					distance=1;//the  distance is 1 tile
					break;
				}
			}
		}
		//We continue to search for supplies since there is no supply with distance=1
		if(distance==0) {
			//If there is no up wall and also the above tile has no up wall
			if(tiles[currentPos].getUp()==false) {
				if(tiles[currentPos+N].getUp()==false) {
					//Checking if the above-above tile has a supply
					for(int i=0;i<supply.length;i++) {
						if(currentPos==supply[i]-2*N) {
							distance=2;//the  distance is 2 tiles
							break;
						}
					}
			}
			}
			
			//If there is no right wall and also the right tile has no right wall
			if(tiles[currentPos].getRight()==false) {
				if(tiles[currentPos+1].getRight()==false) {
					//Checking if the right-right tile has a supply
					for(int i=0;i<supply.length;i++) {
						if(currentPos==supply[i]-2) {
							distance=2;//the  distance is 2 tiles
							break;
						}
					}
			}
			}
			
			//If there is no down wall and also the down tile has no down wall
			if(tiles[currentPos].getDown()==false) {
				if(tiles[currentPos-N].getDown()==false) {
					//Checking if the down-down tile has a supply
					for(int i=0;i<supply.length;i++) {
						if(currentPos==supply[i]+2*N) {
							distance=2;//the  distance is 2 tiles
							break;
						}
					}
			}
			}
			
			//If there is no left wall and also the left tile has no left wall
			if(tiles[currentPos].getLeft()==false) {
				if(tiles[currentPos-1].getLeft()==false) {
					//Checking if the left-left tile has a supply
					for(int i=0;i<supply.length;i++) {
						if(currentPos==supply[i]+2) {
							distance=2;//the  distance is 2 tiles
							break;
						}
					}
			}
			}
			
			//We continue to search for supplies since there is no supply with distance=1 or distance=2
			if(distance==0) {
				//If there is no up wall and also the above tile has no up wall and the above-above tile has no up wall
				if(tiles[currentPos].getUp()==false) {
					if(tiles[currentPos+N].getUp()==false) {
						if(tiles[currentPos+2*N].getUp()==false) {
							//Checking if the above tile of the above-above tile has a supply
							for(int i=0;i<supply.length;i++) {
								if(currentPos==supply[i]-3*N) {
									distance=3;//the  distance is 3 tiles
									break;
								}
							}
				}
				}
				}
				
				//If there is no right wall and also the right tile has no right wall and the right-right tile has no right wall
				if(tiles[currentPos].getRight()==false) {
					if(tiles[currentPos+1].getRight()==false) {
						if(tiles[currentPos+2].getRight()==false) {
							//Checking if the right tile of the right-right tile has a supply
							for(int i=0;i<supply.length;i++) {
								if(currentPos==supply[i]-3) {
									distance=3;//the  distance is 3 tiles
									break;
								}
							}
				}
				}
				}
				
				//If there is no down wall and also the down tile has no down wall and the down-down tile has no down wall
				if(tiles[currentPos].getDown()==false) {
					if(tiles[currentPos-N].getDown()==false) {
						if(tiles[currentPos-2*N].getDown()==false) {
							//Checking if the down tile of the down-down tile has a supply
							for(int i=0;i<supply.length;i++) {
								if(currentPos==supply[i]+3*N) {
									distance=3;//the  distance is 3 tiles
									break;
								}
							}
				}
				}
				}
				
				//If there is no left wall and also the left tile has no left wall and the left-left tile has no left wall
				if(tiles[currentPos].getLeft()==false) {
					if(tiles[currentPos-1].getLeft()==false) {
						if(tiles[currentPos-2].getLeft()==false) {
							//Checking if the left tile of the left-left tile has a supply
							for(int i=0;i<supply.length;i++) {
								if(currentPos==supply[i]+3) {
									distance=3;//the  distance is 3 tiles
									break;
								}
							}
				}
				}
				}
			}
		}
				
		return distance;
	}
	
	//This function returns the distance from Minotaur
	public int findMinotaurDistance(int currentPos,int minotaurPos) {
		int distance=0;
		int N=board.getN();
		//We want to have the tiles of the board
		Tile[] tiles = new Tile[board.getN()*board.getN()];
		for(int i=0;i<tiles.length;i++) {
			tiles[i]=board.tiles[i];
		}
		
		//If there is no up wall
				if(tiles[currentPos].getUp()==false) {
					//Checking if Minotaur is in the above tile
					if(currentPos==minotaurPos-N) {
						distance=1;//the  distance is 1 tile
						}
					}
				
				//If there is no right wall
				if(tiles[currentPos].getRight()==false) {
					//Checking if Minotaur is in the right tile
						if(currentPos==minotaurPos-1) {
							distance=1;//the  distance is 1 tile
						}
				}
				
				//If there is no down wall
				if(tiles[currentPos].getDown()==false) {
					//Checking if Minotaur is in the down tile
						if(currentPos==minotaurPos+N) {
							distance=1;//the  distance is 1 tile
						}
				}
				
				//If there is no left wall
				if(tiles[currentPos].getLeft()==false) {
					//Checking if Minotaur is in the left tile
						if(currentPos==minotaurPos+1) {
							distance=1;//the  distance is 1 tile
						}
				}
				
				//If there is no up wall and also the above tile has no up wall
				if(tiles[currentPos].getUp()==false) {
					if(tiles[currentPos+N].getUp()==false) {
						//Checking if Minotaur is in the above-above tile
							if(currentPos==minotaurPos-2*N) {
								distance=2;//the  distance is 2 tiles
							}
						}
				}
				
				//If there is no right wall and also the right tile has no right wall
				if(tiles[currentPos].getRight()==false) {
					if(tiles[currentPos+1].getRight()==false) {
						//Checking if Minotaur is in the right-right tile
							if(currentPos==minotaurPos-2) {
								distance=2;//the  distance is 2 tiles
							}
						}
				}
				
				//If there is no down wall and also the down tile has no down wall
				if(tiles[currentPos].getDown()==false) {
					if(tiles[currentPos-N].getDown()==false) {
						//Checking if Minotaur is in the down-down tile
							if(currentPos==minotaurPos+2*N) {
								distance=2;//the  distance is 2 tiles
							}
						}
				}
				
				//If there is no left wall and also the left tile has no left wall
				if(tiles[currentPos].getLeft()==false) {
					if(tiles[currentPos-1].getLeft()==false) {
						//Checking if Minotaur is in the left-left tile
							if(currentPos==minotaurPos+2) {
								distance=2;//the  distance is 2 tiles
							}
						}
				}
					
				//If there is no up wall and also the above tile has no up wall and the above-above tile has no up wall
				if(tiles[currentPos].getUp()==false) {
					if(tiles[currentPos+N].getUp()==false) {
						if(tiles[currentPos+2*N].getUp()==false) {
							//Checking if Minotaur is in the above tile of the above-above tile
								if(currentPos==minotaurPos-3*N) {
									distance=3;//the  distance is 3 tiles
								}
							}
				}
				}
				
				//If there is no right wall and also the right tile has no right wall and the right-right tile has no right wall
				if(tiles[currentPos].getRight()==false) {
					if(tiles[currentPos+1].getRight()==false) {
						if(tiles[currentPos+2].getRight()==false) {
							//Checking if Minotaur is in the right tile of the right-right tile
								if(currentPos==minotaurPos-3) {
									distance=3;//the  distance is 3 tiles
								}
							}
				}
				}
				
				//If there is no down wall and also the down tile has no down wall and the down-down tile has no down wall
				if(tiles[currentPos].getDown()==false) {
					if(tiles[currentPos-N].getDown()==false) {
						if(tiles[currentPos-2*N].getDown()==false) {
							//Checking if Minotaur is in the down tile of the down-down tile has a supply
								if(currentPos==minotaurPos+3*N) {
									distance=3;//the  distance is 3 tiles
								}
							}
				}
				}
				
				//If there is no left wall and also the left tile has no left wall and the left-left tile has no left wall
				if(tiles[currentPos].getLeft()==false) {
					if(tiles[currentPos-1].getLeft()==false) {
						if(tiles[currentPos-2].getLeft()==false) {
							//Checking if Minotaur is in the left tile of the left-left tile
								if(currentPos==minotaurPos+3) {
									distance=3;//the  distance is 3 tiles
								}
							}
				}
				}
		
		return distance;
	}
	//This funcion chooses where the player moves
	public int getNextMove(int currentPos, int minotaurPos) {
	//We want to have the tiles of the board
			Tile[] tiles = new Tile[board.getN()*board.getN()];
			for(int i=0;i<tiles.length;i++) {
				tiles[i]=board.tiles[i];
			}
			//We want to have the supplies' tile ids
			int[] supply = new int[board.getS()];
			for(int i=0;i<supply.length;i++) {
				supply[i]=board.supplies[i].getSupplyTileId();
			}
		int temp=0;
		int newPos=0;
		int N=board.getN();
		Random randNum=new Random();
		int rand;
		//Patharray is the array type Integer that will be put in the path
		Integer[] pathArray=new Integer[4];
		//we initialize the struct where we will put the possible moves
		ArrayList<Double[]> evaluation;
		evaluation=new ArrayList<Double[]>();
		
		//We put the possible moves with their evaluations in the ArrayList
		Double copyarray[] = new Double[2];//this helps us with the max value of the evaluations
		evaluation.add(0, new Double[] {1.0, evaluate(currentPos,1,minotaurPos)});
		evaluation.add(1,new Double[] {3.0, evaluate(currentPos,3,minotaurPos)});
		evaluation.add(2,new Double[] {5.0, evaluate(currentPos,5,minotaurPos)});
		evaluation.add(3,new Double[] {7.0, evaluate(currentPos,7,minotaurPos)});
		
		//We find the max value of the evaluations
		copyarray[0]=evaluation.get(0)[0];
		copyarray[1]=evaluation.get(0)[1];
		for(int i=1;i<4;i++) {
			if(copyarray[1]<evaluation.get(i)[1]) {
				copyarray[0]=evaluation.get(i)[0];
				copyarray[1]=evaluation.get(i)[1];
			}
		}
		
		//if max is bigger than 0 then we know that player can move to this direction(it is already checked in the evaluate function)
		if(copyarray[1]>0) {
			//Checking if the up move is the best
			if(copyarray[0]==1.0) {
				pathArray[0]=1;
				newPos=currentPos+N;
			}
			//Checking if the right move is the best
			else if(copyarray[0]==3.0) {
				pathArray[0]=3;
				newPos=currentPos+1;
			}
			//Checking if the down move is the best
			else if(copyarray[0]==5.0) {
				pathArray[0]=5;
				newPos=currentPos-N;
			}
			//Checking if the left move is the best
			else if(copyarray[0]==7.0) {
				pathArray[0]=7;
				newPos=currentPos-1;
			}
		}
		
		//If max is equal to 0 then we must take one case that all the values of evaluations are 0 and another case that one value is <0(only one evaluation can be negative)
		else if(copyarray[1]==0) {
			//Checking if all the evaluations are equal to 0
			if(evaluation.get(0)[1]==0&&evaluation.get(1)[1]==0&&evaluation.get(2)[1]==0&&evaluation.get(3)[1]==0) {
				rand=randNum.nextInt(4);//in order to move randomly
				//1st case: up right down left
				if(rand==0) {
					//Checking if the up wall is false
					if(tiles[currentPos].getUp()==false) {
						pathArray[0]=1;
						newPos=currentPos+N;
					}
					//Checking if the right wall is false
					else if(tiles[currentPos].getRight()==false) {
						pathArray[0]=3;
						newPos=currentPos+1;
					}
					//Checking if the down wall is false
					else if(tiles[currentPos].getDown()==false) {
						pathArray[0]=5;
						newPos=currentPos-N;
					}
					//Checking if the left wall is false
					else if(tiles[currentPos].getLeft()==false) {
						pathArray[0]=7;
						newPos=currentPos-1;
					}
				}
				//2nd case: left up right down
				else if(rand==1) {
					//Checking if the left wall is false
					if(tiles[currentPos].getLeft()==false) {
						pathArray[0]=7;
						newPos=currentPos-1;
					}
					//Checking if the up wall is false
					else if(tiles[currentPos].getUp()==false) {
						pathArray[0]=1;
						newPos=currentPos+N;
					}
					//Checking if the right wall is false
					else if(tiles[currentPos].getRight()==false) {
						pathArray[0]=3;
						newPos=currentPos+1;
					}
					//Checking if the down wall is false
					else if(tiles[currentPos].getDown()==false) {
						pathArray[0]=5;
						newPos=currentPos-N;
					}
				}
				
				//3rd case: down left up right
				else if(rand==2) {
					//Checking if the down wall is false
					if(tiles[currentPos].getDown()==false) {
						pathArray[0]=5;
						newPos=currentPos-N;
					}
					//Checking if the left wall is false
					else if(tiles[currentPos].getLeft()==false) {
						pathArray[0]=7;
						newPos=currentPos-1;
					}
					//Checking if the up wall is false
					else if(tiles[currentPos].getUp()==false) {
						pathArray[0]=1;
						newPos=currentPos+N;
					}
					//Checking if the right wall is false
					else if(tiles[currentPos].getRight()==false) {
						pathArray[0]=3;
						newPos=currentPos+1;
					}
				}
				//4th case: right down left up
				else if(rand==3) {
					//Checking if the right wall is false
					if(tiles[currentPos].getRight()==false) {
						pathArray[0]=3;
						newPos=currentPos+1;
					}
					//Checking if the down wall is false
					else if(tiles[currentPos].getDown()==false) {
						pathArray[0]=5;
						newPos=currentPos-N;
					}
					//Checking if the left wall is false
					else if(tiles[currentPos].getLeft()==false) {
						pathArray[0]=7;
						newPos=currentPos-1;
					}
					//Checking if the up wall is false
					else if(tiles[currentPos].getUp()==false) {
						pathArray[0]=1;
						newPos=currentPos+N;
					}
				}
			}
			//Checking if one evaluation is below zero
			else if(evaluation.get(0)[1]<0||evaluation.get(1)[1]<0||evaluation.get(2)[1]<0||evaluation.get(3)[1]<0) {
				//If the up move has a negative evaluation
				if(evaluation.get(0)[1]<0) {
					rand = randNum.nextInt(3);//in order to move randomly
					//1st case: right left down
					if(rand==0) {
						//Checking if the right wall is false
						if(tiles[currentPos].getRight()==false) {
							pathArray[0]=3;
							newPos=currentPos+1;
						}
						//Checking if the left wall is false
						else if(tiles[currentPos].getLeft()==false) {
							pathArray[0]=7;
							newPos=currentPos-1;
						}
						//Checking if the down wall is false
						else if(tiles[currentPos].getDown()==false) {
							pathArray[0]=5;
							newPos=currentPos-N;
						}
					}
					//2nd case: left down right
					else if(rand==1) {
						//Checking if the left wall is false
						if(tiles[currentPos].getLeft()==false) {
							pathArray[0]=7;
							newPos=currentPos-1;
						}
						//Checking if the down wall is false
						else if(tiles[currentPos].getDown()==false) {
							pathArray[0]=5;
							newPos=currentPos-N;
						}
						//Checking if the right wall is false
						else if(tiles[currentPos].getRight()==false) {
							pathArray[0]=3;
							newPos=currentPos+1;
						}
					}
					//3rd case: down right left
					else if(rand==2) {
						//Checking if the down wall is false
						if(tiles[currentPos].getDown()==false) {
							pathArray[0]=5;
							newPos=currentPos-N;
						}
						//Checking if the right wall is false
						else if(tiles[currentPos].getRight()==false) {
							pathArray[0]=3;
							newPos=currentPos+1;
						}
						//Checking if the left wall is false
						else if(tiles[currentPos].getLeft()==false) {
							pathArray[0]=7;
							newPos=currentPos-1;
						}
					}
				}
				//Checking if the right move has a negative evaluation
				else if(evaluation.get(1)[1]<0) {

					rand = randNum.nextInt(3);//in order to move randomly
					//1st case: up down left
					if(rand==0) {
						//Checking if the up wall is false
						if(tiles[currentPos].getUp()==false) {
							pathArray[0]=1;
							newPos=currentPos+N;
						}
						//Checking if the down wall is false
						else if(tiles[currentPos].getDown()==false) {
							pathArray[0]=5;
							newPos=currentPos-N;
						}
						//Checking if the left wall is false
						else if(tiles[currentPos].getLeft()==false) {
							pathArray[0]=7;
							newPos=currentPos-1;
						}
					}
					//2nd case: down left up
					else if(rand==1) {
						//Checking if the down wall is false
						if(tiles[currentPos].getDown()==false) {
							pathArray[0]=5;
							newPos=currentPos-N;
						}
						//Checking if the left wall is false
						else if(tiles[currentPos].getLeft()==false) {
							pathArray[0]=7;
							newPos=currentPos-1;
						}
						//Checking if the up wall is false
						else if(tiles[currentPos].getUp()==false) {
							pathArray[0]=1;
							newPos=currentPos+N;
						}
					}
					//3rd case: left up down
					else if(rand==2) {
						//Checking if the left wall is false
						if(tiles[currentPos].getLeft()==false) {
							pathArray[0]=7;
							newPos=currentPos-1;
						}
						//Checking if the up wall is false
						else if(tiles[currentPos].getUp()==false) {
							pathArray[0]=1;
							newPos=currentPos+N;
						}
						//Checking if the down wall is false
						else if(tiles[currentPos].getDown()==false) {
							pathArray[0]=5;
							newPos=currentPos-N;
						}
					}
				
				}
				
				//Checking if the down move has a negative evaluation
				else if(evaluation.get(2)[1]<0) {

					rand = randNum.nextInt(3);//in order to move randomly
					//1st case: up right left
					if(rand==0) {
						//Checking if the up wall is false
						if(tiles[currentPos].getUp()==false) {
							pathArray[0]=1;
							newPos=currentPos+N;
						}
						//Checking if the right wall is false
						else if(tiles[currentPos].getRight()==false) {
							pathArray[0]=3;
							newPos=currentPos+1;
						}
						//Checking if the left wall is false
						else if(tiles[currentPos].getLeft()==false) {
							pathArray[0]=7;
							newPos=currentPos-1;
						}
					}
					//2nd case: right left up
					else if(rand==1) {
						//Checking if the right wall is false
						if(tiles[currentPos].getRight()==false) {
							pathArray[0]=3;
							newPos=currentPos+1;
						}
						//Checking if the left wall is false
						else if(tiles[currentPos].getLeft()==false) {
							pathArray[0]=7;
							newPos=currentPos-1;
						}
						//Checking if the up wall is false
						else if(tiles[currentPos].getUp()==false) {
							pathArray[0]=1;
							newPos=currentPos+N;
						}
					}
					//3rd case: left up right
					else if(rand==2) {
						//Checking if the left wall is false
						if(tiles[currentPos].getLeft()==false) {
							pathArray[0]=7;
							newPos=currentPos-1;
						}
						//Checking if the up wall is false
						else if(tiles[currentPos].getUp()==false) {
							pathArray[0]=1;
							newPos=currentPos+N;
						}
						//Checking if the right wall is false
						else if(tiles[currentPos].getRight()==false) {
							pathArray[0]=3;
							newPos=currentPos+1;
						}
					}
				
				}
				
				//Checking if the left move has a negative evaluation
				else if(evaluation.get(3)[1]<0) {
					rand = randNum.nextInt(3);//in order to move randomly
					//1st case: up right down
					if(rand==0) {
						//Checking if the up wall is false
						if(tiles[currentPos].getUp()==false) {
							pathArray[0]=1;
							newPos=currentPos+N;
						}
						//Checking if the right wall is false
						else if(tiles[currentPos].getRight()==false) {
							pathArray[0]=3;
							newPos=currentPos+1;
						}
						//Checking if the down wall is false
						else if(tiles[currentPos].getDown()==false) {
							pathArray[0]=5;
							newPos=currentPos-N;
						}
					}
					//2nd case: right down up
					else if(rand==1) {
						//Checking if the right wall is false
						if(tiles[currentPos].getRight()==false) {
							pathArray[0]=3;
							newPos=currentPos+1;
						}
						//Checking if the down wall is false
						else if(tiles[currentPos].getDown()==false) {
							pathArray[0]=5;
							newPos=currentPos-N;
						}
						//Checking if the up wall is false
						else if(tiles[currentPos].getUp()==false) {
							pathArray[0]=1;
							newPos=currentPos+N;
						}
					}
					//3rd case: down up right
					else if(rand==2) {
						//Checking if the down wall is false
						if(tiles[currentPos].getDown()==false) {
							pathArray[0]=5;
							newPos=currentPos-N;
						}
						//Checking if the up wall is false
						else if(tiles[currentPos].getUp()==false) {
							pathArray[0]=1;
							newPos=currentPos+N;
						}
						//Checking if the right wall is false
						else if(tiles[currentPos].getRight()==false) {
							pathArray[0]=3;
							newPos=currentPos+1;
						}
					}
				
				}
			}
		}
		//Checking if in the newPos the player collects a supply
		for(int i=0;i<supply.length;i++) {
			if(newPos==supply[i]) {
				temp++;
				pathArray[1]=1;
				break;
			}
		}
		//Checking if there is no supply in the new position
		if(temp==0) {
			pathArray[1]=0;
		}
		
		//Putting in the third position of the pathArray the value that is returned from the findSupplyDistance(this is the distance of the new position of Theseus from the nearest supply)
		pathArray[2]=findSupplyDistance(newPos);
		
		//Putting in the fourth position of the pathArray the value that is returned from the findMinotaurDistance(this is the distance of the new position of Theseus from Minotaur)
		pathArray[3]=findMinotaurDistance(newPos,minotaurPos);

		
		//We put the new pathArray in the first position of the path
		path.add(0, pathArray);
		
		return newPos;
	}

	//This function uses the move function and the getNextMove function and moves the player
	public int[] SmartMove(int currentPos,int minotaurPos) {
		getNextMove(currentPos,minotaurPos);//we renew the path
		
		return move(currentPos,path.get(0)[0]);
	}

	public void statistics(int counter) {	
		//The total moves of Theseus, it appears when the game ends

		//Checking if Theseus collects a supply in that round
		if(path.get(counter)[1]==1) {
			setScore(getScore()+1);
		}
		//Printing the round
			System.out.println("Round "+round+"\n");
			round++;
			
			System.out.println("Total supplies' collected by Theseus: " + score);//we print the number of the supplies that player has collected
			//Checking if the nearest supply is one tile away
			if(path.get(counter)[2]==1) {
				System.out.println("The nearest supply is 1 tile away");
			}
			//Checking if the nearest supply is 2 tiles away
			else if(path.get(counter)[2]==2) {
				System.out.println("The nearest supply is 2 tiles away");
			}
			//Checking if the nearest supply is 3 tiles away
			else if(path.get(counter)[2]==3) {
				System.out.println("The nearest supply is 3 tiles away");
			}
			else System.out.println("There is not any supply nearby");
			//Checking if the minotaur is 1 tile away
			if(path.get(counter)[3]==1) {
				System.out.println("Theseus,before Minotaur moves, is 1 tile away from Minotaur");
			}
			//Checking if the minotaur is 2 tiles away
			else if(path.get(counter)[3]==2) {
				System.out.println("Theseus,before Minotaur moves, is 2 tiles away from Minotaur");
			}
			//Checking if the minotaur is 3 tiles away
			else if(path.get(counter)[3]==3) {
				System.out.println("Theseus,before Minotaur moves, is 3 tiles away from Minotaur");
			}
			else System.out.println("Theseus,before Minotaur moves, is not near to Minotaur");
			
			System.out.println();			
			System.out.println();
			
			//If dice is one player moves up
			if(path.get(counter)[0]==1) {
				up++;
			}
			//if dice is 3 player moves right
			else if(path.get(counter)[0]==3) {
				right++;
			}
			//if dice is 5 player moves down
			else if(path.get(counter)[0]==5) {
				down++;
			}
			//if dice is 7 player moves left
			else if(path.get(counter)[0]==7) {
				left++;
			}
			
			//The total moves of Theseus, it appears when the game ends
			
			if(counter==0) {
				System.out.println("Theseus moved up "+ up+ " times");
				System.out.println("Theseus moved right "+ right+ " times");
				System.out.println("Theseus moved down "+ down+ " times");
				System.out.println("Theseus moved left "+ left+ " times");
			
			}
	}
}
