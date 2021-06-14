# Genetic Algorithms: Visualization of Evolution

## Introduction
This work was originally done as high school graduation thesis for the academic year 2016-2017 at the <em> [Istituto Statale di Istruzione Superiore “Arturo Malignani”](http://www.malignani.ud.it) Liceo delle Scienze Applicate</em> (Udine, Italy). While researching about genetic algorithms for my thesis, I decided to also create my own genetic algorithm that visually and intuitively showcases step by step the procedures involved to generate solutions to certain problems by taking advantage of Darwin's Evolutionary Genetics. The problem solved by this visualization is trivial (generate a string that matches a target string only using randomly generated characters/genes), but it is still quite effective in displaying the mechanisms of genetic algorithms and how they can be scaled up to solve more convoluted problems.

<br>


## Evolutionary Cycle

### Generating the initial population 

![Generating initial population by Andrea Covre](/figures/initial-generation.gif "Generating initial population")

The initial population is composed of strings formed by random characters that represent the genes. The topmost string is the target string and represents the *environment* the population has to evolve to fit (which happens when the correct characters appear at the correct positions). 

![Initial population by Andrea Covre](/figures/initial-population.png "Initial population")
``` JavaScript
void createPopulation() {
  for (int i = 0; i < popSize; i++) {
    for (int j = 0; j < targetLength; j++) {
      population[i][j] = charPool[ floor( random(0, charPool.length) )];
    }
  }
}
```

In an actual genetic algorithm the population size would be much larger than just 12 *individuals* as to increase diversity and accelerate the evolutionary process, however for the sake of an effective visualization and readably the population size is limited to just 12 *individuals*.

<br>

### Fitness calculation

Fitness is the value we use to represent how suitable one individual (a solution to the problem) is within the environment set by the problem we are trying to solve. In this case, each matching character exponentially increases the fitness of the individual.

![Fitness calculation animation by Andrea Covre](/figures/fitness.gif "Fitness calculation animation")

``` JavaScript
void calcFitness() {
  for (int i = 0; i < popSize; i++) { 
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
```

The higher the fitness of one individual the higher are its chances to reproduce and pass down its genes, allowing these good/useful genes to remain in the population pool and be spread across future generations.

![Fitness calculation and chances of reproduction by Andrea Covre](/figures/fitness-calculation.png "Fitness calculation")

<br>

### Parents selection

To create a *child* of the next generation one or more indivudals can be selected based on their fitness score. 

![Parents selection by Andrea Covre](/figures/parents-selection.png "Parents selection")

In this algorithm every child is generated using two parents and any individual has a chance of becoming a parent equal to the ratio between its own fitness score and the population's total fitness score.

![Parents selection animation by Andrea Covre](/figures/parents-selection.gif "Parents selection animation")

``` JavaScript
void getParents() {
  parentA = matingPool.get(floor(random(totalFitness)));
  parentB = matingPool.get(floor(random(totalFitness)));

  while (parentA == parentB) {                   //to be sure that the same parent is not chosen twice
    parentB = matingPool.get(floor(random(totalFitness)));
  }
}
```

<br>

### Child generation

In the case of a one-parent reproduction, the child will have the same genes as the parent (unless a mutation occurs). While with a two-parents reproduction the child will have a mix of genes coming from both parents through one of the following hereditary methods:

* **even cross-over**: half of child's genes will come from one parent, while other half will come from the second parent (in this case the left half of the child's genes comes from the first parent while the right half comes from the second parent so <span style="color:red">FORK</span> + <span style="color:blue">PLAY</span> = <span style="color:red">FO</span><span style="color:blue">AY</span>).
* **random cross-over**: *x* genes to the left will come from the first parents while *y* genes to the right will come from the second parents such that *x* + *y* = the total number of genes that constitutes an individual with both *x* and *y* > 0 (<span style="color:red">FORK</span> + <span style="color:blue">PLAY</span> = <span style="color:red">F</span><span style="color:blue">LAY</span> or <span style="color:red">FO</span><span style="color:blue">AY</span> or <span style="color:red">FOR</span><span style="color:blue">Y</span>).
* **fragmented cross-over**: every child's gene has a 50% chance of coming from either parent (<span style="color:red">FORK</span> + <span style="color:blue">PLAY</span> = <span style="color:red">F</span><span style="color:blue">L</span><span style="color:red">RK</span> or <span style="color:blue">P</span><span style="color:red">O</span><span style="color:blue">A</span><span style="color:red">K</span> or ...)

![Genes selection and child generation by Andrea Covre](/figures/genes-selection.gif "Genes selection and child generation")

``` JavaScript
void makeNewChild(String mode) {
  if (mode == "crossover") {
    crossOverPoint = floor(random(1, targetLength-1));   // random cross-over
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
```

In this algorithm, the chosen method is the fragmented cross-over in order to increase diversity within the population.

![Child Generation](/figures/child-generation.png "Child Generation")

<br>

### Child mutation

Some genes that could be part of the solution to the problem might not be present in population's genes pool, or might get lost between generations, therefore they need to be introduced through mutations. Mutations not only introduce new genes, but also keep the genes pool diversified and dynamic.
After the child is generated from the parents, a mutating function is applied so that every gene has a certain probability to mutate into a different letter.

![Mutation on a child's genes animation by Andrea Covre](/figures/mutation.gif "Mutation on a child's genes animation")

``` JavaScript
void applyMutation () {
    for (int i = 0; i<targetLength; i++) {    
        if (random(0, 100) <= mutationRate) {  
            newGeneration[childIndex-1][i] = charPool[floor(random(0, charPool.length))];
        } 
    }
}
```

In the example below the child's 4th gene was supposed to be inherited by the first parent (the blue one), however a mutation occurred (highlighted in red) that mutated that gene from a "S" to a "J".

![Mutation on a child's gene by Andrea Covre](/figures/mutation.png "Mutation on a child's gene")

<br>

### Next generation and evolutionary development

![New population by Andrea Covre](/figures/new-population.png "New population")

Once all the children have been generated, the parent population gets replaced by the newly computed population and the evolutionary cycle  repeats itself until an individual matches certain criteria that identify it as a solution to the problem.

<!-- ![Generation 206 by Andrea Covre](/figures/generation-206.png "Generation 206") -->
![Looping animation of the evolutionary process by Andrea Covre](/figures/full-execution.gif "Looping animation of the evolutionary process ")

After 287 generations we finally have an individual that perfectly matches with the environmental conditions set by the problem, in fact the 4th strings has all the correct characters at the correct positions.

![Perfect individual at gen #287 by Andrea Covre](/figures/generation-287-final.png "Perfect individual at gen #287")

Such individual, therefore, represent the solution to the problem. It's not always possible to achieve perfect fitness scores (optimal solutions), however the higher the fitness score the better the approximation of the solution is.

<br>

## Files

### Visualization_of_Evolution_V_1_2_0_EXP.pde

This code is the controller and manages the execution of the 14 phases of the algorithm (from the initial generation to replacing the old generation with the new one). Moreover it sets-up the graphics environment, handles keyboard inputs, declares and sets valuable variables and constants (mutation rate, reproduction mode, population size etc.).

### FitnessFunctions.pde

This file contains the functions needed to calculate the fitness score and then the mating probability of each individual.

### ReproductionFunctions.pde

It contains all the functions related to the reproductions phases, such as `createPopulation()`, `getParents()`,  `makeNewChild()`, `applyMutation()` and `transcriptNewGen()`.

### DisplayElements.pde

It manages and contains all the variables, constants and functions in charge of creating and displaying graphical elements and information about the algorithm execution.

### StatusBar.pde

It contains the code needed to create and display a status bar at the bottom of the screen that shows relevant information.

<br>

## Execution

To run the visualization you will need to download [Processing](https://processing.org), load the files in its IDE and run the code from there.

<br>

## Resources

## COVRE_ANDREA-TESI_MALIGNANI_2017.pdf - (only available in Italian 🇮🇹)

This PDF is the original paper submitted in 2017 as high school graduation thesis.
It thoroughly discusses Genetic Algorithm's terminology, techniques, procedures, mathematical and biological foundations and mechanisms, Darwin's theory of evolution, current and future real-world applications and more in-depth documentation about the visualization software.

[!["High School Graduation Thesis - Andrea Covre"](/figures/COVRE_ANDREA-TESI-COVER.jpg)]("https://github.com/andrea-covre/genetic.algorithms-Visualization_of_Evolution/COVRE_ANDREA-TESI_MALIGNANI_2017.pdf")