void calcFitness() {
  for (int i = 0; i < popSize; i++) {     //resetting fitness value before calculating it again
    fitnessValue[i] = 0;
  }

  for (int i = 0; i < popSize; i++) {
    int correctGene = 0;
    for (int j = 0; j < targetLength; j++) {
      if (population[i][j] == target[j]) {
        rightGene [i][j] = 1;
        correctGene += 1;
        fitnessValue[i] += 10;
      } else {
        rightGene [i][j] = 0;
        correctGene += 0;
      }
    }
    fitnessValue[i] = pow(2, correctGene);
  }
}

void calcProbability() {
  matingPool.clear();  //clear out the mating pool "bucket"
  textSize(20);
  pushMatrix();
  translate(20, 20);
  text("Chances", cellSize*targetLength +150, 50);

  for (int i = 0; i<popSize; i++) {
    probability[i] = fitnessValue[i]/totalFitness * 100;
    text(round(probability[i]) + "%", cellSize*targetLength +150, 80+45*i );

    //add agents n times based on the fitness
    for (int j = 0; j < fitnessValue[i]; j++) {
      matingPool.add(i);
    }
  }
  popMatrix();
}
