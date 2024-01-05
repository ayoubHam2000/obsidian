
### 1. **Undirected Graph**

- **Definition**: In an undirected graph, edges have no direction. If there is an edge between node AA and node BB, you can travel from AA to BB and from BB to AA.
- **Example**: Social networks, where connections between people are mutual.

### 2. **Directed Graph (Digraph)**

- **Definition**: In a directed graph, each edge has a direction, going from one node to another. If there is an edge from node AA to node BB, you can only travel from AA to BB, not necessarily from BB to AA.
- **Example**: Web pages and hyperlinks, where each link points from one page to another.

### 3. **Weighted Graph**

- **Definition**: In a weighted graph, each edge has an associated weight or cost. This can apply to both directed and undirected graphs.
- **Example**: Road networks, where edges represent roads, and weights represent distances or travel times.

### 4. **Unweighted Graph**

- **Definition**: In an unweighted graph, all edges are considered equal, without any weight or cost.
- **Example**: A basic social network graph where connections have no weights.

### 5. **Simple Graph**

- **Definition**: A simple graph has no loops (edges connected at both ends to the same vertex) and no more than one edge between any two different vertices.

### 6. **Multigraph**

- **Definition**: A multigraph can have multiple edges (parallel edges) between the same pair of nodes.
- **Example**: A transportation network where multiple flights connect the same pair of cities.

### 7. **Cyclic Graph**

- **Definition**: A cyclic graph contains at least one cycle, which is a path that starts and ends at the same node with no other repetitions of nodes and edges.
- **Example**: Graphs representing circuits.

### 8. **Acyclic Graph**

- **Definition**: An acyclic graph has no cycles. A special type of directed acyclic graph is known as a DAG (Directed Acyclic Graph).
- **Example**: Task scheduling where tasks are nodes and edges represent dependencies.

### 9. **Connected Graph**

- **Definition**: In an undirected graph, a graph is connected if there is a path between every pair of nodes.
- **Example**: Any network where all devices can communicate with each other directly or indirectly.

### 10. **Disconnected Graph**

- **Definition**: In an undirected graph, a graph is disconnected if at least one pair of nodes does not have a path between them.
- **Example**: Separate subnetworks within a larger network.

### 11. **Complete Graph**

- **Definition**: In a complete graph, there is an edge between every pair of nodes.
- **Example**: A network where every computer is directly connected to every other computer.

### 12. **Bipartite Graph**

- **Definition**: A bipartite graph's nodes can be divided into two disjoint sets such that every edge connects a node in one set to a node in the other set.
- **Example**: Job assignment problems where jobs are one set of nodes and workers are another set.

### 13. **Subgraph**

- **Definition**: A subgraph is a portion of a graph that consists of a subset of its nodes and edges.
- **Example**: Any smaller network extracted from a larger network for analysis.

### 14. **Tree**

- **Definition**: A tree is an acyclic connected graph. In a directed tree, there's a special node called the root from which every other node can be reached.
- **Example**: Organizational charts or file directory structures.

### 15. **Forest**

- **Definition**: A forest is a disjoint set of trees.
- **Example**: A collection of multiple hierarchies or structures.

### 16. **Planar Graph**

- **Definition**: A graph is planar if it can be drawn on a plane without any edges crossing.
- **Example**: Graphs representing geographical maps.
---
### Spanning tree

- **Definition**: In the mathematical field of graph theory, a spanning tree T of an undirected graph G is a subgraph that is a tree which includes all of the vertices of G. In general, a graph may have several spanning trees, but a graph that is not connected will not contain a spanning tree.

- **A minimum spanning tree** or minimum weight spanning tree is a subset of the edges of a connected, edge-weighted undirected graph that connects all the vertices together, without any cycles and with the minimum possible total edge weight. That is, it is a spanning tree whose sum of edge weights is as small as possible
- ![[Screenshot from 2024-05-31 14-16-33.png]]