//=================  Sketch info ================= //<>//
String sketchName = "Visualization of Evolution";
String sketchVersion = "1.2.0";
String sketchAuthor = "Andrea Covre";


//Target
String targetPhrase = "algoritmo genetico";
int targetLength = targetPhrase.length();
int[] target = new int[targetLength]; //Array that will have in each "cell" a char of the target phrase

//Population
int popSize = 12; //12
int[][] population = new int[popSize][targetLength];  //array containing in each cell an array with the chars of the phrase

int generation = 1;

int[][] rightGene = new int[popSize][targetLength];  //array containing 0s if a gene does not match 1s if it does match
float[] fitnessValue = new float[popSize];
int totalFitness = 0;
float[] probability = new float[popSize];

//Genes
int[] charPool = { ' ', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};

//Reproduction
ArrayList<Integer> matingPool = new ArrayList<Integer>();
int parentA = -1;
int parentB = -1;
int[][] newGeneration = new int[popSize][targetLength];  //array containing in each cell an array with the chars of the phrase
int childIndex = 1;
int newGenSize = 0;
int crossOverPoint = 0;
String reproductionMode = "fragmentation";   //modes: +crossover - +fragmentation
char[] newChildMap = new char[targetLength];
float mutationRate = 5;   // (%)
int[] tempChildMutation = new int[targetLength];
char[] mutationMap = new char[targetLength];

//Graphic
float cellSize = 25;
int animationCounterX = 0;
int animationCounterY = 0;
int delayAnimation = 1;
float scalingFactor = 1;
float xTranslation = 0;
float yTranslation = 0;

//Execution managment
int phase = 0;
//boolean showFitness = false;
String status = "Operative";
int settedRate = 70;
boolean looping = false;

void setup() {
  size(1250, 680, P2D);

  frameRate(settedRate);

  targetPhrase = targetPhrase.toUpperCase();  //Making the target phrase all uppercase

  //assigning to each cell of the array one char in int format
  for (int i = 0; i<targetLength; i++) { 
    target[i] = targetPhrase.charAt(i);
  }

  //creating the population: generation #1
  createPopulation();
}

void draw() {
  

  background(0);
  stroke(255, 0, 0);
  textAlign(CENTER);
  textSize(20);

  drawTarget();

  pushMatrix();
  translate(xTranslation, yTranslation);

  //showing a random selection of genes for each individual of the population
  if (phase == 0) {
    createPopulation();
    showPopulation();
  }

    //Showing how the starting generation is composed
    if (phase == 1) {
      //Drawing population
      showPopulation();
    }

    //highlighting right genes
    if (phase == 2) {
      calcFitness();
      showFitness(animationCounterX, animationCounterY);

      if (animationCounterY < popSize) {
        animationCounterY += 1;
      } else {
        animationCounterY = 0;
        animationCounterX += 1;
      }
      delay(delayAnimation);
    }

    //showing the fitness of each phrase an the total fitness
    if (phase == 3) {
      animationCounterY = popSize;
      animationCounterX = targetLength;
      calcFitness();
      showFitness(animationCounterX, animationCounterY);
      showFitValue();
    }

    //showing the chances of each phrase to become a parent
    if (phase == 4) {
      calcFitness();
      showFitness(animationCounterX, animationCounterY);
      showFitValue();
      calcProbability();
    }

    //showing the matingPool ROulette
    if (phase == 5) {

      showFitValue();
      calcProbability();
      getParents();
      showParents();

      showNewGeneration();

    }

    //show which phrasis will be the parents of the next kid
    if (phase == 6) {
      showFitValue();
      calcProbability();
      showParents();
      showNewGeneration();
    }

    //showing the new kid and how it got its genes from its parents
    if (phase == 7) {
      showFitValue();
      calcProbability();
      showParentsGenes();

      makeNewChild(reproductionMode);

      showNewChild();
      showNewGeneration();
    }

    //a crossOverPoint is choosen, this phases stops COPoint animation and shows how the child got its genes
    if (phase == 8) {
      showFitValue();
      calcProbability();
      showParentsGenes();
      showNewChild();
      showNewGeneration();
    }

    if (phase == 9) {
      showFitValue();
      calcProbability();
      showParentsGenes();
      showNewChild();
      applyMutation();
      showNewGeneration();
    }

    if (phase == 10) {
      showFitValue();
      calcProbability();
      showParentsGenes();
      showNewChild();
      showMutation();
      showNewGeneration();
    }

    //if the new pop has not the same size of the parents' pop increase by 1 the childIndex and then repeat phase 5, 6, 7 and 8
    if (phase == 11 ) {
      //drawing stuff just to fill the black frame that this phase genearates
      showFitValue();
      calcProbability();
      showParentsGenes();
      showNewGeneration();
      if (childIndex == popSize) {
        showNewChild();
      }

      if (childIndex < popSize) {
        phase = 5;
        childIndex++;
      } else {
        //if the size of the new gen is equal to the size of the parents' gen, then go to the next phase (10)
        phase = 12;
        childIndex++; //CHK
      }

      showNewGeneration();
    }

    if (phase == 12) {
      showFitValue();
      calcProbability();
      showPopulation();
      showNewGeneration();
      println("---- " + childIndex);
    }

    if (phase == 13) {
      showFitValue();
      calcProbability();
      showPopulation();
      showNewGeneration();
      println("---- " + childIndex);
    }

    if (phase == 14) {
      transcriptNewGen();
      childIndex = 1;
      animationCounterX = 0;
      animationCounterY = 0;
      phase = 1; //1
      generation++;
    }

  popMatrix();

  //KeyBoard inputs manager
  if (keyPressed) {
    switch(key) {
    case ' ':
      phase += 1;
      delay(10);
      break;

    case 'l':
      if (looping == true) {
        looping = false;
        status = "Operative";
      } else {
        looping = true;
        status = "Looping";
      }
      delay(10);
      break;
    }
    delay(80);
  }

  if (looping == true) {
    if (frameCount % 2 == 0) {
      phase++;
    }
  }

  displayStatusBar();

  println(phase + " " + frameRate + " " + matingPool.size());
}
