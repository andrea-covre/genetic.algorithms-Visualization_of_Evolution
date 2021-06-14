void createPopulation() {
  for (int i = 0; i < popSize; i++) {
    for (int j = 0; j < targetLength; j++) {
      population[i][j] = charPool[ floor( random(0, charPool.length) )];
    }
  }
}

void getParents() {
  parentA = matingPool.get(floor(random(totalFitness)));
  parentB = matingPool.get(floor(random(totalFitness)));

  while (parentA == parentB) {                   //to be sure that the same parents is not choosen twice
    parentB = matingPool.get(floor(random(totalFitness)));
  }
}

void makeNewChild(String mode) {
  if (mode == "crossover") {
    crossOverPoint = floor(random(1, targetLength-1));   //randominly selecting a crossover point, then take half from A the half from B
    println(" corssover point : " + crossOverPoint);
    for (int i = 0; i < targetLength; i++) {
      if (i < crossOverPoint) {
        newGeneration[childIndex-1][i] = population[parentA][i];
      } else {
        newGeneration[childIndex-1][i] = population[parentB][i];
      }
    }
  }

  if (mode == "fragmentation") {
    for (int i = 0; i < targetLength; i++) {
      if (floor(random(0, 2)) == 0) {
        newChildMap[i] = 'A';
        newGeneration[childIndex-1][i] = population[parentA][i];
      } else {
        newChildMap[i] = 'B';
        newGeneration[childIndex-1][i] = population[parentB][i];
      }
    }
  }
}

void applyMutation () {
  pushMatrix();
  translate(700, 80+45*(childIndex-1));
  stroke(0, 255, 151);
  for (int i = 0; i<targetLength; i++) {
    tempChildMutation[i] = newGeneration[childIndex-1][i];   //creating a temprorary child equal to the one of indexChild
                                                             
    boolean mutation = false;

    if (random(0, 100) <= mutationRate) {
      mutation = true;
    }

    if (mutation) {
      tempChildMutation[i] = charPool[ floor( random(0, charPool.length) )];
      mutationMap[i] = 'M';
      fill(255, 0, 0);
    } else {
      mutationMap[i] = 0;
      noFill();
    }

    beginShape();
    vertex(cellSize*i, cellSize);   //vertex Bottom-Left (1)
    vertex(cellSize*i, 0);         //vertex Top-Left (2)
    vertex(cellSize*(i+1), 0);   //vertex Top-Right (3)
    vertex(cellSize*(i+1), cellSize);   //vertex Bottom-Right (4)
    endShape(CLOSE);
    fill(255);
    text(char(tempChildMutation[i]), (cellSize*i)+cellSize/2, cellSize/1.25);
    print(newGeneration[childIndex-1][i] + " ");
    println();
  }
  popMatrix();
}

void transcriptNewGen () {
  for (int j = 0; j < popSize; j++) {
    for (int i = 0; i < targetLength; i++) {
      population[j][i] = newGeneration[j][i];
    }
  }
}
