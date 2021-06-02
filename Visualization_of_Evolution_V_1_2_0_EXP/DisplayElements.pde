void drawTarget() {
  pushMatrix();
  translate(20, 20);
  for (int i = 0; i<targetLength; i++) {
    fill(0);
    beginShape();
    vertex(cellSize*i, cellSize);   //vertex Bottom-Left (1)
    vertex(cellSize*i, 0);         //vertex Top-Left (2)
    vertex(cellSize*(i+1), 0);   //vertex Top-Right (3)
    vertex(cellSize*(i+1), cellSize);   //vertex Bottom-Right (4)
    endShape(CLOSE);
    fill(255);
    text(char(target[i]), (cellSize*i)+cellSize/2, cellSize/1.25);
  }
  popMatrix();
}

void showPopulation() {
  for (int j = 0; j < popSize; j++) {
    pushMatrix();
    translate(20, 80+45*j);
    for (int i = 0; i<targetLength; i++) {
      fill(0);
      beginShape();
      vertex(cellSize*i, cellSize);   //vertex Bottom-Left (1)
      vertex(cellSize*i, 0);         //vertex Top-Left (2)
      vertex(cellSize*(i+1), 0);   //vertex Top-Right (3)
      vertex(cellSize*(i+1), cellSize);   //vertex Bottom-Right (4)
      endShape(CLOSE);
      fill(255);
      text(char(population[j][i]), (cellSize*i)+cellSize/2, cellSize/1.25);
    }
    popMatrix();
  }
}

void showParents() {
  for (int j = 0; j < popSize; j++) {
    pushMatrix();
    translate(20, 80+45*j);
    for (int i = 0; i<targetLength; i++) {
      fill(0);

      if ((j == parentA)||(j == parentB)) {
        stroke(0, 255, 0);
      } else {
        stroke(255, 0, 0);
      }

      beginShape();
      vertex(cellSize*i, cellSize);   //vertex Bottom-Left (1)
      vertex(cellSize*i, 0);         //vertex Top-Left (2)
      vertex(cellSize*(i+1), 0);   //vertex Top-Right (3)
      vertex(cellSize*(i+1), cellSize);   //vertex Bottom-Right (4)
      endShape(CLOSE);
      fill(255);
      text(char(population[j][i]), (cellSize*i)+cellSize/2, cellSize/1.25);
    }
    popMatrix();
  }
}

void showFitness(int counterX, int counterY) {
  for (int j = 0; j < popSize; j++) {
    pushMatrix();
    translate(20, 80+45*j);
    //animation marking right genes
    for (int i = 0; i<targetLength; i++) {
      if ((i <= counterX)&&(j <= counterY)) {   
        if (rightGene[j][i] == 1) {
          fill(0, 255, 0, 140);
        } else {
          fill(255, 0, 0, 140);
        }
      } else {
        fill(0, 0, 0);
      }

      if (i < counterX) {
        if (rightGene[j][i] == 1) {
          fill(0, 255, 0, 140);
        } else {
          fill(255, 0, 0, 140);
        }
      }
      
      beginShape();
      vertex(cellSize*i, cellSize);   //vertex Bottom-Left (1)
      vertex(cellSize*i, 0);         //vertex Top-Left (2)
      vertex(cellSize*(i+1), 0);   //vertex Top-Right (3)
      vertex(cellSize*(i+1), cellSize);   //vertex Bottom-Right (4)
      endShape(CLOSE);
      fill(255);
      text(char(population[j][i]), (cellSize*i)+cellSize/2, cellSize/1.25);
    }
    popMatrix();
  }
}

void showFitValue() {
  totalFitness = 0;  //reset total fitness
  pushMatrix();
  translate(20, 20);
  text("Fitness", cellSize*targetLength +50, 50);
  for (int i = 0; i<popSize; i++) {
    if (fitnessValue[i]==0) {
      //fitnessValue[i] = 1;      //if fitness is 0 give 1 for mercy
    } 

    //counting the total fitness
    totalFitness += fitnessValue[i];

    text(nf(fitnessValue[i], 0, 0), cellSize*targetLength +50, 80+45*i);
  }
  textSize(16);
  text("Total Fitness:", cellSize*targetLength +50, 100+45*popSize-30);
  text(totalFitness, cellSize*targetLength +50, 100+45*popSize-10);

  popMatrix();
}

void showParentsGenes() {
  for (int j = 0; j < popSize; j++) {
    pushMatrix();
    translate(20, 80+45*j);
    for (int i = 0; i<targetLength; i++) {
      fill(0);

      //coloring the genes that each parents donates
      if (reproductionMode == "crossover") {
        if (j == parentA) {
          stroke(0, 255, 0);
          if (i < crossOverPoint) {
            fill(18, 143, 250);
          }
        } else if (j == parentB) {
          stroke(0, 255, 0);
          if (!(i < crossOverPoint)) {
            fill(250, 177, 18);
          }
        } else {
          stroke(255, 0, 0);
        }
      }

      if (reproductionMode == "fragmentation") {
        stroke(0, 255, 0);

        if (j == parentA) {
          if (newChildMap[i] == 'A') {
            fill(18, 143, 250);
          }
        } else if (j == parentB) {
          if (newChildMap[i] == 'B') {
            fill(250, 177, 18);
          }
        } else {
          stroke(255, 0, 0);
        }
      }


      beginShape();
      vertex(cellSize*i, cellSize);   //vertex Bottom-Left (1)
      vertex(cellSize*i, 0);         //vertex Top-Left (2)
      vertex(cellSize*(i+1), 0);   //vertex Top-Right (3)
      vertex(cellSize*(i+1), cellSize);   //vertex Bottom-Right (4)
      endShape(CLOSE);
      fill(255);
      text(char(population[j][i]), (cellSize*i)+cellSize/2, cellSize/1.25);
    }
    popMatrix();
  }
}

void showNewChild() {
  pushMatrix();
  translate(700, 80+45*(childIndex-1));
  stroke(0, 255, 151);
  for (int i = 0; i<targetLength; i++) {


    if (reproductionMode == "crossover") {
      if (i < crossOverPoint) {
        fill(18, 143, 250);
      } else {
        fill(250, 177, 18);
      }
    }

    if (reproductionMode == "fragmentation") {
      if (newChildMap[i] == 'A') {
        fill(18, 143, 250);
      } else {
        fill(250, 177, 18);
      }
    }

    beginShape();
    vertex(cellSize*i, cellSize);   //vertex Bottom-Left (1)
    vertex(cellSize*i, 0);         //vertex Top-Left (2)
    vertex(cellSize*(i+1), 0);   //vertex Top-Right (3)
    vertex(cellSize*(i+1), cellSize);   //vertex Bottom-Right (4)
    endShape(CLOSE);
    fill(255);
    text(char(newGeneration[childIndex-1][i]), (cellSize*i)+cellSize/2, cellSize/1.25);
    print(newGeneration[childIndex-1][i] + " ");
    println();
  }
  popMatrix();
}

void showMutation() {
  pushMatrix();
  translate(700, 80+45*(childIndex-1));
  stroke(0, 255, 151);
  for (int i = 0; i<targetLength; i++) {

    newGeneration[childIndex-1][i] = tempChildMutation[i];

    if (mutationMap[i] == 'M') {
      fill(255, 0, 0);
    } else {
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
  }
  popMatrix();
}

void showNewGeneration() {
  stroke(255, 0, 200);
  for (int j = 0; j < childIndex-1; j++) {
    pushMatrix();
    translate(700, 80+45*j);
    for (int i = 0; i<targetLength; i++) {
      fill(0);
      beginShape();
      vertex(cellSize*i, cellSize);   //vertex Bottom-Left (1)
      vertex(cellSize*i, 0);         //vertex Top-Left (2)
      vertex(cellSize*(i+1), 0);   //vertex Top-Right (3)
      vertex(cellSize*(i+1), cellSize);   //vertex Bottom-Right (4)
      endShape(CLOSE);
      fill(255);
      text(char(newGeneration[j][i]), (cellSize*i)+cellSize/2, cellSize/1.25);
    }
    popMatrix();
  }
}
