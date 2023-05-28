void setNextGen() {  //<>//
  scrubNext(); 
  //countCells();

  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {

      //Checks if arrayIndex is empty, in case it has already been defined in a previous iteration of the forloop
      if (cellsNext[i][j] != 0) {
        continue; //Skips stuff underneath and moves to next iteration
      }

      if (cells[i][j] == human) {    
        cutTrees(i, j); //cuts down trees beside humans
        if (buildCity(i, j)) {
          continue;
        }
        moveHuman(i, j);   
        humanDeath(i, j);  
    
        if ((cellsNext[i][j] != human ) ) {  //replaces block human was in previously with grass if no other human moves into the cell
          cellsNext[i][j] = grass;
        }
      }
    

      //Spawning humans and trees and urban
      else {
        if ((nearCity(i, j) == true) && (random(0, 1)<humanChance) && (cells[i][j] == grass) && (treeCount>treeThreshold3)) {
          cellsNext[i][j] = human;
        } 
        else if ((nearCity(i, j) == true) && (random(0, 1)<urbChance) && (cells[i][j] != city) && (treeCount>treeThreshold2)) {
          cellsNext[i][j] = urban;
        } 
        else {
          cellsNext[i][j] = cells[i][j];
          if ((nearCity(i,j) == false) && (random(0, 1)<treeRegrow) && (cells[i][j]== grass)) {
            cellsNext[i][j] = tree;
          }
        }
      }
    }
  }
  
  //printing tree, human, and city count to terminal
  println("trees:", treeCount);
  println("humans:", humanCount);
  println("cities:", cityCount);
  println();  
  
  
  ////reset count every frame
  //treeCount = 0;
  //humanCount = 0;
  //cityCount = 0;
}
