import de.bezier.guido.*;
static int NUM_ROWS = 10;
static int NUM_COLS = 10;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20 
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
static int clear = NUM_ROWS * NUM_COLS;
public boolean FirstClick = false;
private boolean lock = false;
private boolean instantWin = false;



void setup ()
{
    size(1000, 1000);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    mines = new ArrayList<MSButton>(); 
    createButtons();
    setMines();
  
}

public void createButtons(){
     buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int rows = 0; rows < NUM_ROWS; rows++){
     for(int cols = 0; cols < NUM_COLS; cols++){
       buttons[rows][cols] = new MSButton(rows,cols); 
       clear--;
    }
   }
    
}

public void setMines()
{
  for(int i = 0; i< (NUM_ROWS * NUM_COLS)/4; i++){
   int balls = (int)(Math.random()*NUM_ROWS);
   int balls2 =(int)(Math.random()*NUM_COLS);

   if(!mines.contains((buttons[balls][balls2]))) mines.add(buttons[balls][balls2]);
 }
}
public void draw ()
{ 
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
    
}
public void keyPressed(){
 if(key == 'w') instantWin = true;
}

public boolean isWon(){ 
  boolean temp = true;
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
     if(!mines.contains(buttons[i][j]) && !(buttons[i][j].clicked == true)) temp = false;
   }
  }
  if(instantWin == true) return true;
  return temp; 
}


public void displayLosingMessage()
{
for(int i = 0; i < NUM_ROWS; i++){
   for(int j = 0; j < NUM_COLS; j++){
     text(100,100,100);
     buttons[i][j].clicked = true;

   }
 }
 
   for(int i = 0; i < NUM_ROWS; i++){
   for(int j = 0; j < NUM_COLS; j++){
     text(100,100,100);
     buttons[i][j].clicked = true;

   }
 }
      buttons[4][3].myLabel = "womp";  
      
         buttons[4][4].myLabel = "womp";  
      buttons[4][5].myLabel = "you";
      buttons[5][4].myLabel = "lose!";
     buttons[00][01].myLabel = "lol";
 
}
public void displayWinningMessage()
{
   
  textSize(30);
  if(lock == false){
  buttons[4][1].setLabel("You");
  buttons[4][2].setLabel("are a");
  buttons[4][3].setLabel("real");
  buttons[4][4].setLabel("mine");
  buttons[4][5].setLabel("sweepe ");
  buttons[4][6].setLabel("r pro!!!");
  }
  lock = true; 
}
public boolean isValid(int row, int col){
  
  if(row < NUM_ROWS && row >= 0 && col>=0 && col < NUM_COLS) return true;
  return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int i = row-1; i <= row+1; i++){
      for(int j = col-1; j <= col+1; j++){
        if(isValid(i,j) && mines.contains(buttons[i][j])) numMines++; 
      }
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 1000/NUM_COLS;
         height = 1000/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
      if(FirstClick == false){
       if(mines.contains(this)) mines.remove(this); 
       FirstClick = true;
      }  
   if(lock == false){
      clicked = true;
        if(mouseButton == RIGHT){
          if(this.flagged == true) this.flagged = false;
          else this.flagged = true; 
         
        }
        if(mouseButton == LEFT){
          if(mines.contains(this)){ displayLosingMessage(); lock = true;}//display losing message
          else if(countMines(this.myRow,this.myCol) > 0) this.myLabel = Integer.toString(countMines(myRow,myCol));
          else{
            for(int i = myRow-1; i <= myRow+1; i++){
            
            for(int j = myCol-1; j <= myCol+1; j++){
              if(isValid(i,j) && buttons[i][j].clicked == false) buttons[i][j].mousePressed(); 
            }
            
            
            }
          }          
        }
   } 
        //your code here
    }
    public void draw () 
    {    
        
      if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 ); 
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
