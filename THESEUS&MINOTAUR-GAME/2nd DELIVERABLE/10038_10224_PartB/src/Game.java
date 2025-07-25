//Tzamtzis Marios 10038 6949214612 tzamtzis@ece.auth.gr
//Tsipis Pantelis 10224 6947548593 panttsip@ece.auth.gr

import java.util.ArrayList;
import java.util.Random;

public class Game {
	//Variable
	int round;//the round of the game
	
	//Default constructor
	public Game() {
		round=0;
	}
	
	//Constructor with argument
	public Game(int round) {
		this.round=round;
	}
	
	//Copy constructor
	public Game(Game game) {
		round=game.round;
	}
	
	//Setter and getter
	public void setRound(int round) {
		this.round=round;
	}
	
	public int getRound() {
		return round;
	}
	
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub
			Game game=new Game(1);//Creating game
			Random randNum=new Random();
			int dice;
			ArrayList<Integer[]> smart = new ArrayList<Integer[]>();
			Board board = new Board(15, 4, 338);//Creating the board(15x15, 4 supplies, max walls=338)
			board.createBoard();
			int arr []=new int [4];//The array from the function player.move
			//Creating players
			HeuristicPlayer theseus=new HeuristicPlayer(1,"Theseus",board,0,0,0,smart);
			Player minotaur=new Player(2,"Minotaur",board,0,board.getN()/2,board.getN()/2);
			for(int i=0;i<100;i++) {
				//printing the round
				System.out.println("Round: "+game.getRound());
				//printing the board
				for (int k = 0; k < 31; k++){
					for (int j = 0; j < 15; j++){
						System.out.print(board.getStringRepresentation(theseus.getX()*board.getN()+theseus.getY(),minotaur.getX()*board.getN()+minotaur.getY())[k][j]);
						}
					System.out.println();
				}
				//setting the number of rounds
				game.setRound(game.getRound()+1);
				//Theseus playing
					//calling the function move
					arr=theseus.SmartMove(theseus.getX()*board.getN()+theseus.getY(),minotaur.getX()*board.getN()+minotaur.getY());
					//setting the minotaur's coordinates 
					theseus.setX(arr[1]);
					theseus.setY(arr[2]);
					
					//Checking if Theseus has collected all the supplies
					if(theseus.getScore()==board.getS()) {
						System.out.println("Theseus has collected all the supplies. Minotaur gets killed by falling in trapdoor");//Theseus wins
						break;
					}
					//Checking if both Theseus and Minotaur are on the same tile
					else if(theseus.getX()==minotaur.getX()&&theseus.getY()==minotaur.getY()) {
						System.out.println("Minotaur kills Theseus");//Minotaur wins
						break;
					}
					
				//minotaur playing
					//calling the function move
					dice= (randNum.nextInt(4)+10);
					arr=minotaur.move(minotaur.getX()*board.getN()+minotaur.getY(),dice);
					//setting the minotaur's coordinates
					minotaur.setX(arr[1]);
					minotaur.setY(arr[2]);
					
				//Checking if both Theseus and Minotaur are on the same tile	
				if(theseus.getX()==minotaur.getX()&&theseus.getY()==minotaur.getY()) {
					System.out.println("Minotaur kills Theseus");//Minotaur wins
					break;
				}
				//If we are in the last round and neither Theseus and Minotaur are on the same tile nor Theseus has collected all the supplies
				else if(i==99){
					System.out.println("Draw! No one wins and the players get petrified!");
				}
			}
			
			//printing the board when the game ends
			for (int k = 0; k < 31; k++){
				for (int j = 0; j < 15; j++){
					System.out.print(board.getStringRepresentation(theseus.getX()*board.getN()+theseus.getY(),minotaur.getX()*board.getN()+minotaur.getY())[k][j]);
					}
				System.out.println();
			}
			
			//Setting Theseus' score 0 to print it right from statistics function
			theseus.setScore(0);
			//Printing the total moves of Theseus
			for(int i=game.getRound()-2;i>=0;i--) {
			theseus.statistics(i);
			}

			
		}


		
	}

