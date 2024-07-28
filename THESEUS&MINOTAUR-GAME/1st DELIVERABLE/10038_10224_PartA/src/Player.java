//Tzamtzis Marios 10038 6949214612 tzamtzis@ece.auth.gr
//Tsipis Pantelis 10224 6947548593 panttsip@ece.auth.gr

import java.util.Random;

public class Player {
	//Variables
	int playerId;//the id of the player
	String name;//the name of the player
	Board board;//the board of the game
	int score;//the score of the player, in which 1 point is added when the player finds a supply
	int x;//the x-coordinate where the player is
	int y;//the y-coordinate where the player is
	
	//Default Constructor
	public Player() {
		playerId=0;
		name="";
		score=0;
		x=0;
		y=0;
	}
	
	//Constructor with arguments
	public Player(int playerId,String name,Board board,int score,int x,int y) {
		this.playerId=playerId;
		this.name=name;
		this.board=board;
		this.score=score;
		this.x=x;
		this.y=y;
	}
	
	//Copy constructor
	public Player(Player player) {
		playerId=player.playerId;
		name=player.name;
		board=player.board;
		score=player.score;
		x=player.x;
		y=player.y;
	}
	
	//Setters and getters of all the variables
	public void setPlayerId(int playerId) {
		this.playerId=playerId;
	}
	
	public void setName(String name) {
		this.name=name;
	}
	
	public void setBoard(Board board) {
		this.board=board;
	}
	
	public void setScore(int score) {
		this.score=score;
	}
	
	public void setX(int x) {
		this.x=x;
	}
	
	public void setY(int y) {
		this.y=y;
	}
	
	public int getPlayerId() {
		return playerId;
	}
	
	public String getName() {
		return name;
	}
	
	public Board getBoard() {
		return board;
	}
	
	public int getScore() {
		return score;
	}
	
	public int getX() {
		return x;
	}
	
	public int getY() {
		return y;
	}
	
	public int[] move(int id){
		int[] array=new int [4];
		Random direction=new Random();
		int dice;
								/*  0: down
									1: left
									2: up
									3: right  */
		dice=direction.nextInt(4);
		//Checking if the direction is down
		if(dice==0) {
			//If there is a down wall the player cannot move down
			if(board.getTiles()[id].getDown()==true) {
				System.out.println(name + " cannot move!");
				array[0]=id;//tileId
				array[1]=id/board.getN();//x-coordinate
				array[2]=id%board.getN();//y-coordinate
				array[3]=-1;//supply-id
				return array;
			}
			//If there is not a down wall, he moves down
			else {
				System.out.println(name + " moves down");
				//The new tileId,x,y
				array[0]=id-board.getN();
				array[1]=id/board.getN()-1;
				array[2]=id%board.getN();
				//If there is a supply on the new tile Theseus gets it
				for(int i=0;i<board.getS();i++) {
					if(board.getSupplies()[i].getSupplyTileId()==array[0]&&(name=="Theseus")) {
						System.out.println(name + " found the supply: S"+(board.getSupplies()[i].getSupplyId()));
						//Vanishing the supply that was collected by Theseus
						board.getSupplies()[i].setX(0);
						board.getSupplies()[i].setY(0);
						board.getSupplies()[i].setSupplyTileId(-1);
						score++;//adds one point to the score
						array[3]=board.getSupplies()[i].getSupplyId();//which supply is collected
						return array;
					}
					else {
						array[3]=-1;
						
					}
				}
				
			}
		}
		//Checking if the direction is left
		else if(dice==1) {
			//If there is a left wall the player cannot move left
			if(board.getTiles()[id].getLeft()==true) {
				System.out.println(name + " cannot move!");
				array[0]=id;//tileId
				array[1]=id/board.getN();//x-coordinate
				array[2]=id%board.getN();//y-coordinate
				array[3]=-1;//supply-id
				return array;
			}
			//If there is not a left wall, he moves left
			else {
				System.out.println(name + " moves left");
				//The new tileId,x,y
				array[0]=id-1;
				array[1]=id/board.getN();
				array[2]=id%board.getN()-1;
				//If there is a supply on the new tile Theseus gets it
				for(int i=0;i<board.getS();i++) {
					if(board.getSupplies()[i].getSupplyTileId()==array[0]&&(name=="Theseus")) {
						System.out.println(name + " found the supply: S"+(board.getSupplies()[i].getSupplyId()));
						//Vanishing the supply that was collected by Theseus
						board.getSupplies()[i].setX(0);
						board.getSupplies()[i].setY(0);
						board.getSupplies()[i].setSupplyTileId(-1);
						score++;//adds one point to the score
						array[3]=board.getSupplies()[i].getSupplyId();//which supply is collected
					return array;
					}
					else {
						array[3]=-1;
						
					}
				}
				
			}
		}
		//Checking if the direction is up
		else if(dice==2) {
			//If there is an up wall the player cannot move up
			if(board.getTiles()[id].getUp()==true) {
				System.out.println(name + " cannot move!");
				array[0]=id;//tileId
				array[1]=id/board.getN();//x-coordinate
				array[2]=id%board.getN();//y-coordinate
				array[3]=-1;//supply-id
				return array;
			}
			//If there is not an up wall, he moves up
			else {
				System.out.println(name + " moves up");
				//The new tileId,x,y
				array[0]=id+board.getN();
				array[1]=id/board.getN()+1;
				array[2]=id%board.getN();
				//If there is a supply on the new tile Theseus gets it
				for(int i=0;i<board.getS();i++) {
					if(board.getSupplies()[i].getSupplyTileId()==array[0]&&(name=="Theseus")) {
						System.out.println(name + " found the supply: S"+(board.getSupplies()[i].getSupplyId()));
						//Vanishing the supply that was collected by Theseus
						board.getSupplies()[i].setX(0);
						board.getSupplies()[i].setY(0);
						board.getSupplies()[i].setSupplyTileId(-1);
						score++;//adds one point to the score
						array[3]=board.getSupplies()[i].getSupplyId();//which supply is collected
					return array;
					}
					else {
						array[3]=-1;
						
					}
				}
			}
		}
		//Checking if the direction is right
		else if(dice==3) {
			//If there is a right wall the player cannot move right
			if(board.getTiles()[id].getRight()==true) {
				System.out.println(name + " cannot move!");
				array[0]=id;
				array[1]=id/board.getN();
				array[2]=id%board.getN();
				array[3]=-1;
				return array;
			}
			//If there is not a right wall, he moves right
			else {
				System.out.println(name + " moves right");
				//The new tileId,x,y
				array[0]=id+1;
				array[1]=id/board.getN();
				array[2]=id%board.getN()+1;
				//If there is a supply on the new tile Theseus gets it
				for(int i=0;i<board.getS();i++) {
					if(board.getSupplies()[i].getSupplyTileId()==array[0]&&(name=="Theseus")) {
						System.out.println(name + " found the supply: S"+(board.getSupplies()[i].getSupplyId()));
						board.getSupplies()[i].setX(0);
						board.getSupplies()[i].setY(0);
						board.getSupplies()[i].setSupplyTileId(-1);
						score++;//adds one point to the score
						array[3]=board.getSupplies()[i].getSupplyId();//which supply is collected
					return array;
					}
					else {
						array[3]=-1;
						
					}
				}
			}
		
		}
		//If Theseus has not found any supplies
		if(name=="Theseus")
			System.out.println(name + " has not found any supplies");
		return array;
	}
}
