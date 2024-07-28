//Tzamtzis Marios 10038 6949214612 tzamtzis@ece.auth.gr
//Tsipis Pantelis 10224 6947548593 panttsip@ece.auth.gr

public class Supply {
	//Variables
	int supplyId;//supply's id
	int x;//x-coordinate of the supply
	int y;//y-coordinate of the supply
	int supplyTileId;//tile's id where the supply is
	
	//Default Constructor
	public Supply() {
		supplyId = 0;
		x = 0;
		y = 0;
		supplyTileId = 0;
	}
	
	//Constructor with arguments
	public Supply(int supplyId, int x, int y, int supplyTileId) {
		this.supplyId = supplyId;
		this.x = x;
		this.y = y;
		this.supplyTileId= supplyTileId;
	}
	
	//Copy constructor
	public Supply(Supply supply) {
		this.supplyId = supply.supplyId;
		this.x = supply.x;
		this.y = supply.y;
		this.supplyTileId = supply.supplyTileId;
	}
	
	//Setters and getters for all the variables
	public void setSupplyId(int supplyId) {
		this.supplyId = supplyId;
	}
	
	public void setX(int x) {
		this.x = x;
	}
	
	public void setY(int y) {
		this.y = y;
	}
	
	public void setSupplyTileId(int supplyTileId) {
		this.supplyTileId = supplyTileId;
	}
	
	public int getSupplyId() {
		return supplyId;
	}
	
	public int getX() {
		return x;
	}
	
	public int getY() {
		return y;
	}
	
	public int getSupplyTileId() {
		return supplyTileId;
	}
	
	
	
	
	
}
