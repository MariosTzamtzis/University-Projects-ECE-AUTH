//Tzamtzis Marios 10038 6949214612 tzamtzis@ece.auth.gr
//Tsipis Pantelis 10224 6947548593 panttsip@ece.auth.gr

public class Tile {
	//Variables
	int tileId;//tile's id
	int x;//x-coordinate of the board
	int y;//y-coordinate of the board
	boolean up;//true if there is a wall in the north
	boolean down;//true if there is a wall in the south
	boolean left;//true if there is wall in the west
	boolean right;//true if there is a wall in the east
	
	//Default constructor
	public Tile() {
		tileId = 0;
		x = 0;
		y = 0;
		up = false;
		down = false;
		left = false;
		right = false;
	}
	
	//Constructor with arguments
	public Tile(int tileId, int x, int y, boolean up, boolean down, boolean left, boolean right) {
		this.tileId = tileId;
		this.x = x;
		this.y = y;
		this.up = up;
		this.down = down;
		this.left = left;
		this.right = right;
	}
	
	//Copy constructor
	public Tile(Tile tile) {
		this.tileId = tile.tileId;
		this.x = tile.x;
		this.y = tile.y;
		this.up = tile.up;
		this.down = tile.down;
		this.left = tile.left;
		this.right = tile.right;
	}
	
	//Setters and getters of all the variables
	public void setTileId(int tileId) {
		this.tileId = tileId;
	}
	
	public void setX(int x) {
		this.x = x;
	}
	
	public void setY(int y) {
		this.y = y;
	}
	
	public void setUp(boolean up) {
		this.up = up;
	}
	
	public void setDown(boolean down) {
		this.down = down;
	}
	
	public void setLeft(boolean left) {
		this.left = left;
	}
	
	public void setRight(boolean right) {
		this.right = right;
	}
	
	public int getTileId() {
		return tileId;
	}
	
	public int getX() {
		return x;
	}
	
	public int getY() {
		return y;
	}
	
	public boolean getUp() {
		return up;
	}
	
	public boolean getDown() {
		return down;
	}
	
	public boolean getLeft() {
		return left;
	}
	
	public boolean getRight() {
		return right;
	}

}
