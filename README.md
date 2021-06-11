# Genetic Algorithms: Visualization of Evolution

## Introduction
This work was originally done as high school graduation thesis for the academic year 2016-2017 at the <em> [Istituto Statale di Istruzione Superiore “Arturo Malignani”](http://www.malignani.ud.it) Liceo delle Scienze Applicate</em> (Udine, Italy). While researching about genetic algorithms for my thesis, I decided to also create my own genetic algorithm that visually and intuitively showcases step by step the procedures involved to generate solutions to certain problems by taking advantage of Darwin's Evolutionary Genetics. The problem solved by this visualization is trivial (generate a string that matches a target string only using randomly generated characters/genes), but it is still quite effective in displaying the mechanisms of genetic algorithms and how they can be scaled up to solve more convoluted problems.


## Evolutionary Cycle

### Generating the initial population 

![Generating initial population by Andrea Covre](/figures/initial-generation.gif "Generating initial population")

The initial population is composed of strings formed by random characters that represent the genes. The top most string is the target string and represents the *environment* the population has to evolve to fit (which happens when the correct characters appear at the correct positions). 

![Initial population by Andrea Covre](/figures/initial-population.png "Initial population")

In an actual genetic algorithm the population size would be much larger than just 12 *individuals* as to increase diversity and accelerate the evolutionary process, however for the sake of an effective visualization and readably the population size is limited to just 12.

### Fitness calculation

Fitness is the value we use to represent how suitable one individual (a solution to the problem) is within the environment set by the problem we are trying to solve. In this case, each matching character exponentially increases the fitness of the individual.

![Fitness calculation animation by Andrea Covre](/figures/fitness.gif "Fitness calculation animation")

![Fitness calculation and chances of reproduction by Andrea Covre](/figures/fitness-calculation.png "Fitness calculation")

![Parents selection by Andrea Covre](/figures/parents-selection.png "Parents selection")

![Child Generation](/figures/child-generation.png "Child Generation")

![Mutation on a child's gene by Andrea Covre](/figures/mutation.png "Mutation on a child's gene")

![New population by Andrea Covre](/figures/new-population.png "New population")

![Generation 206 by Andrea Covre](/figures/generation-206.png "Generation 206")

![Perfect individual by Andrea Covre](/figures/generation-287-final.png "Perfect individual")