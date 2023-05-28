
//Deciding movement of humans
void moveHuman(int i, int j) {
  ySpeed = round(random(-1, 1));  //Assigning random speeds to humans of either -1, 0, or 1
  xSpeed = round(random(-1, 1));

  int iNext = i + ySpeed;  //Assigning variables to the coordinates of cells that the human wants to move into
  int jNext = j + xSpeed;
 
  if (checkBlocked(iNext, jNext) == false) {  
    try {
      cellsNext[iNext][jNext] = human;
    }
    catch (Exception e) { //In case the cellsNext is off the grid, turns into grass to look like human has left the screen
      cellsNext[i][j] = grass; 
    }
  } 
  else {
    cellsNext[i][j] = human;  //If the cell is already occupied, human doesn't move
  }
}

//Deciding survival of humans
void humanDeath(int i, int j) {
  int humanNeighbours = 0;
  try {
    for (int a=-1; a<2; a++) {
      for (int b=-1; b<2; b++) {
        if (cells[i+a][j+b] == human) {  //Counting number of neighbouring human cells
          humanNeighbours += 1;  
        }
      }
    }
  }
  catch (Exception e) { 
  }

  if (humanNeighbours > 3) { //If a human with more than 3 neighbours dies to represent overpopulation 
    cellsNext[i][j] = grass;
  } 
  else if (random(0, 1)<danger) { //random chance of humans dying from natural causes
    cellsNext[i][j] = grass;
  }
}

//Cutting down trees around a human
void cutTrees(int i, int j) {
  for (int a=-1; a<2; a++) {
    for (int b=-1; b<2; b++) {
      try {
        if (cells[i+a][j+b] == tree) {
          if (random(0, 1)<treeDemand) {  //chance that neighbouring trees are cut down 
            cellsNext[i+a][j+b] = grass;
            cutCount +=1; 
          }
        }
      } 
      catch (Exception e) {
      }
    }
  }
}

//Checks if the cell human wants to move into is already occupied by humans, cities, or suburbs
boolean checkBlocked(int iNext, int jNext) {
  boolean blocked = false;
  try {
    blocked = (cells[iNext][jNext] == human)  || 
      (cells[iNext][jNext] == urban) ||
      (cellsNext[iNext][jNext] == human) || 
      (cellsNext[iNext][jNext] == city) || 
      (cellsNext[iNext][jNext] == urban);
  }
  catch (Exception e) {
  }
  return blocked;
}

//function to check if there is nearby urban area
boolean nearCity( int i, int j) {
  boolean nearCity = false;
  try {
    for (int a=-1; a<2; a++) {
      for (int b=-1; b<2; b++) {
        if (cells[i+a][j+b] == urban) {
          nearCity = true;
        }
      }
    }
  }
  catch (Exception e) {
  }
  return nearCity;
}

//Spawning new humans with mouse
void mouseDragged() {
  try {
    int col = int((mouseX - padding)/cellSize);
    int row = int((mouseY - padding)/cellSize);
    cellsNext[row][col] = human;
    overwriteGen();
    redraw(); //this forces Processing to re-draw the screen right away
  }
  catch (Exception e) {
  }
}
