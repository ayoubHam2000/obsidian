##  Related

![[Key Words#Algorithms]]

### Key Words

`Online Algorithm` | `instance of a problem` | `Key => Satellite data` `record` | 
`short circuiting` | `quadratic function` | `worst-case running time` | `average-case` | `randomized algorithm` | `rate of growth or order of growth`

 ### What is An Algorithm
 
* Informally, an algorithm is any well-deufined computational procedure that takes some value, or set of values, as `input` and produces some value, or set of values, as `output` in a finite amount of time. An algorithm is thus a sequence of computational steps that transform the input into the output.

### instance of a problem

- In general, an `instance of a problem` consists of the input (satisfying whatever constraints are imposed in the problem statement) needed to compute a solution to the problem.

### Correct Algorithm

- An algorithm for a `computational problem` is `correct` if, for every `problem instance` provided as input, it halts  its computing in finite time and outputs the correct solution to the problem instance. A correct algorithm solves the given computational problem. An incorrect algorithm might not halt at all on some input instances, or it might halt with an incorrect answer.

### Data structure

* A data structure is a way to store and organize data in order to facilitate access and modifications.

## Loop Invariant

1. `Initialization`: It is true prior to the ûrst iteration of the loop.
2. `Maintenance`: If it is true before an iteration of the loop, it remains true before the next iteration.
3. `Termination`: The loop terminates, and when it terminates, the invariant gives us a useful property that helps show that the algorithm is correct.
*fast example* => $$ 1.\ A[0] \ should \ hold \ for \ the \ initialization $$ $$ 2.\ from \ A[0: i - 1] \ to \ A[0:i]\ should\ hold $$ $$3.\ because\ the\ loop\ terminate\ and\ (2)\ A[0:n]\ hold $$
## Analyzing algorithms

Analyzing an algorithm has come to mean predicting the resources that the algo- rithm requires. You might consider resources such as memory, communication bandwidth, or energy consumption.

- Most of this book assumes a generic one-processor, random-access machine `(RAM)`
- The running time of the algorithm is the sum of running times for each statement executed. A statement that takes c<sub> k</sub> steps to execute and executes m times contributes m.c<sub> k</sub> to the total running time.  We usually denote the running time of an algorithm on an input of size n by T(n) .
- $$ \theta(n^2) \ theta\ n\text-squared $$ 

## Notes

- For smaller input merge sort usually can be slower than insertion sort $$(n \approx 44)$$