import g4p_controls.*;

//Urban Sprawl
//By: Timothy Lu

//Parameters for users to play with
int n = 50;
float cellSize;
int padding = 50;
float frameSpeed = 20;

float humanProb = 0.01;    //Works best around 0.005 or just use mouse to spawn humans
float treeProb = 0.6;      //Chance that a cell starts as a tree 
float treeRegrow = 0.005;  //Chance that an empty grass cell will grow into a tree
float treeDemand = 0.3;    //Chance that human will cut down nearby tree
float danger = 0.015;      //Chance that a human dies 
float cityChance = 0.002;  //Chance that a human builds a city
float urbChance = 0.005;   //Chance that urban area spreads
float humanChance = 0.005; //Chance that a city spawns a human near it 
float treeThreshold1 = (n*n)*0.5;
float treeThreshold2 = (n*n)*0.2;
float treeThreshold3 = (n*n)*0.1;

//Global variables
color[][] cells = new color[n][n];
color[][] cellsNext = new color[n][n];
color human = color(200,150,150); 
color tree = color(83, 101, 53);
color grass = color(150, 218, 101);
color city = color(0);
color urban = color(120);
int xSpeed;
int ySpeed;
int treeCount = 0;
int cutCount = 0;
int humanCount = 0;
int cityCount = 0;
int totalCells = n*n;
//int[][] treeAge = new int[n][n];


void setup() {
  size(1200, 800);
  frameRate(frameSpeed);
  cellSize = (width-400-2*padding)/n;
  setFirstGen();
}

void draw() { 
  background(200);
  float y = padding;
  countCells();
  updateCount();
  
  
  for (int i=0; i<n; i++) {  //Drawing grid of squares and filling with pre-determined colors
    for (int j=0; j<n; j++) {
      float x = padding + j*cellSize;
      fill(cells[i][j]);
      square(x, y, cellSize);
    }
    y += cellSize;
  }
  setNextGen(); //Setting up next gen of cells
  overwriteGen(); //overwriting array cells with cellsNext before running next generation
}

void scrubNext() {  //Empties cellsNext 
  cellsNext = new color[n][n];
}

void overwriteGen() {  
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      cells[i][j] = cellsNext[i][j];
    }
  }
}

void updateCount() {
  //Drawing title
  textSize(50);
  fill(100);
  text("Urban Sprawl", 800,100);
  textSize(20);
  text("Drag mouse to spawn humans", 800, 150);
  text("press 'x' to destroy society", 800, 200);
  
  //draws tree, human, and city count to screen
  fill(100);
  text("Trees: " + treeCount, 800, 250);
  text("Humans: " + humanCount, 800, 300);
  text("Cities: " + cityCount, 800, 350);
}

void countCells() {  //Counts the number of trees, humans, and cities. 
  treeCount = 0;
  humanCount = 0;
  cityCount = 0; 
  
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      if (cells[i][j] == tree) {
        treeCount += 1;
      } 
      else if (cells[i][j] == human) {
        humanCount += 1;
      } 
      else if (cells[i][j] == city) {
        cityCount +=1;
      }
    }
  }
}
