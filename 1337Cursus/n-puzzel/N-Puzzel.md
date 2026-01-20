## Related



## Heuristic

Heuristics provide a way to navigate complex problems and make decisions quickly
- Shortcuts to produce solutions that may not be optimal
- Heuristics are useful where an exhaustive search is impractical or impossible
- A techniques that can guide decision-making.

- **Common Types**:
    - **Availability Heuristic**: Making a decision based on how easily examples come to mind. For example, estimating the likelihood of events based on recent memories or news.
    - **Representativeness Heuristic**: Judging the probability of an event by comparing it to an existing prototype in our minds. For instance, assuming someone is a librarian because they are quiet and wear glasses.
    - **Anchoring Heuristic**: Relying heavily on the first piece of information encountered (the "anchor") when making decisions.  In salary negotiations, the initial offer often sets the stage, influencing the final agreed-upon salary even if the initial figure is arbitrary.

- **Advantages and Disadvantages**:
    
    - **Advantages**: Heuristics are fast, require less cognitive effort, and are often effective enough for making practical decisions.
    - **Disadvantages**: They can lead to cognitive biases and errors in judgment, as they may oversimplify complex situations and ignore important information.

### Notes

- Manhattan distance
- Euclidean distance
- Minkowski Distance
- Hamming Distance
	- The Hamming Distance between two strings of the same length is the number of positions at which the corresponding characters are different.
- Out of place tiles
- Number of tiles out of row + Number of tiles out of column
---
Admissible and Consistent Heuristics
https://www.youtube.com/watch?v=0K0H-z7HZ1o
- **Admissible Heuristic**: A heuristic is admissible if it never overestimates the true cost to reach the goal. This ensures the optimality of the A* algorithm.
- **Consistent Heuristic**: A heuristic is consistent (or monotonic) if it satisfies the condition that for every node nn and every successor n′n′ of nn, the estimated cost of reaching the goal from nn is no greater than the cost of getting from nn to n′n′ plus the estimated cost from n′n′ to the goal. Formally, $h(n)≤c(n,n′)+h(n′)h(n)≤c(n,n′)+h(n′)$.

![[Screenshot from 2024-05-29 18-22-41.png]]

![[Screenshot from 2024-05-29 18-34-25.png]]
![[Screenshot from 2024-05-29 18-38-58.png]]![[Screenshot from 2024-05-29 18-52-52.png]]

---
Heuristic Search
https://www.youtube.com/watch?v=2-4w7LZ-l_Q&list=PLyqSpQzTE6M91QQRszLbb7QYKrD1EYJx8&index=25

- **Uninformed Search**: Does not use any heuristic information. like (Breath first search and depth first search)
	- **Queue-Based**: Uses a simple queue (FIFO) to keep track of nodes to be expanded next.
- **Informed Search**: Uses a heuristic to guide the search. like (Best first search)
	- **Heuristic-Based Expansion**: Expands the most promising node according to the heuristic function.
	- **Priority Queue-Based**: Uses a priority queue (often a min-heap) to prioritize nodes based on their heuristic value.
- Both depth first search and breadth first search are oblivious of the goal
- What is needed is a search algorithm with a sense of direction]
- **The heuristic function** `estimates` the cost.
	- estimate via distance
	- this estimate can be used to decide which node to pick from.
![[Screenshot from 2024-05-30 17-42-19.png|400]]

![[Screenshot from 2024-05-29 19-26-19.png]]

DFS and BFS
https://www.youtube.com/watch?v=QqdN7LH3jeA&list=PLyqSpQzTE6M91QQRszLbb7QYKrD1EYJx8&index=22
- Breath first search
- Depth first search
- Best first search

## Uniform-Cost Search vs Greedy Search

- **Uniform-Cost Search (UCS)**:
    - **Pros**: Finds the optimal path, complete (guaranteed to find a solution if one exists), does not require a heuristic.
    - **Cons**: Can be slower and more memory-intensive due to exhaustive exploration.
    - **UCS** is essentially Dijkstra's algorithm applied in a general graph context
- **Greedy Search**:
    - **Pros**: Faster, simpler, efficient with a good heuristic, less memory-intensive.
    - **Cons**: Not guaranteed to find the optimal path, performance dependent on the quality of the heuristic.

## Algorithms

- Pass
## Keywords

- algorithms
	- A*
	- Best first search
	- Depth first search
	- Best first search
	- Uniform cost search
	- Dijkstra
- heuristics functions
- informed search  / unformed search
- priority queue
- min-heap
- basic Graph Theory
	- directed, undirected, weighted, unweighted
	- Nodes (Vertices)
	- Edges can have weights (costs).
	- Paths: nodes connected by edges forms a path.
- Admissible Heuristic never overestimates the true cost to reach the goal.
- Consistent Heuristic $h(n)≤c(n,n′)+h(n′)$
- g(n): Cost from the Start Node to Node n
- h(n): Heuristic Estimate of the Cost from Node n to the Goal
## Next
Stochastic Local Search
Genetic algorithm
BFS DFS graphs TSP
Monti carlo
genitic algo
Uniform Cost Search (UCS)
Genetic algorithms (GAs) and SAT (Satisfiability Testing)
Ant Colony Optimization (ACO)
