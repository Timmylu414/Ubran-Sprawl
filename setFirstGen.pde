
//Setting first generation of cells to draw to the screen
void setFirstGen() {  
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {

      float humanRand = random(0, 1);
      float treeRand = random(0, 1);

      if (treeRand < treeProb) { 
        cells[i][j] = tree;
      } 
      else if (humanRand < humanProb) {
        cells[i][j] = human;
      } 
      else {
        cells[i][j] = grass;
      }
    }
  }
}
