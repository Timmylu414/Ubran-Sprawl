
//Building a city 
boolean buildCity(int i, int j) {
  if ((random(0, 1)<cityChance) && (checkCity(i, j) == true) && (treeCount > treeThreshold1)) {  //chance that a human builds a city if there are no nearby cities
    cellsNext[i][j] = city;      
    for (int a=-1; a<2; a++) {  //Building suburban area around the city center
      for (int b=-1; b<2; b++) {
        if (b!= 0 || a!=0) {  //Makes sure to not overwrite the city 'center' with urban area
          cellsNext[i+a][j+b] = urban;
        }
      }
    }
    println("city built");
    return true;
  } else {
    return false;
  }
}

//Checks if there are other cities in 3-block radius
boolean checkCity(int i, int j) { 
  boolean canBuild = true;
  try {  
    for (int a=-3; a<4; a++) {
      for (int b=-3; b<4; b++) {
        if ((cells[i+a][j+b] == urban)||(cells[i+a][b+j] == city)) { 
          canBuild = false;
        }
      }
    }
  }
  catch(Exception e) { //Cannot build city if at the edge of the grid
    canBuild = false;
  }
  return canBuild;
}

//destroys all cities and urban area
void keyPressed() {
  if (key == 'x') {
    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        if ((cellsNext[i][j] == city) || (cellsNext[i][j] == urban)) {
          cellsNext[i][j] = grass;
          overwriteGen();
          redraw(); //this forces Processing to re-draw the screen right away
        }
      }
    }
  }
}
