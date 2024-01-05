
## Related

- [[Types of graph]]
- [[Types of graph#Spanning tree]]
- [[graph algorithms]]

A **general graph** refers to a data structure used to represent a set of objects (called nodes or vertices) and the relationships (called edges) between them.

### Key Concepts

1. **Nodes (Vertices)**:
    
    - These are the individual elements or points in the graph. Each node can represent an entity such as a city, a computer, a person, etc.
2. **Edges**:
    
    - These are the connections between nodes. An edge can represent a relationship or a pathway, such as a road between cities or a link between computers in a network.
3. **Directed vs. Undirected Graphs**:
    
    - **Directed Graph (Digraph)**: Each edge has a direction, indicating a one-way relationship (e.g., a one-way street).
    - **Undirected Graph**: Edges have no direction, indicating a bidirectional relationship (e.g., a two-way street).
4. **Weighted vs. Unweighted Graphs**:
    
    - **Weighted Graph**: Each edge has a weight (or cost), representing the cost or distance between nodes.
    - **Unweighted Graph**: All edges are considered equal, typically having no associated cost or weight.

### Types of Graphs

- **Simple Graph**: A graph without loops (edges connecting a node to itself) and multiple edges between the same pair of nodes.
- **Multigraph**: A graph that can have multiple edges (parallel edges) between the same pair of nodes.
- **Cyclic Graph**: A graph that contains at least one cycle, a path where the start and end nodes are the same.
- **Acyclic Graph**: A graph without cycles. A Directed Acyclic Graph (DAG) is a directed graph with no directed cycles.
- **Connected Graph**: In an undirected graph, there is a path between any two nodes.
- **Disconnected Graph**: In an undirected graph, some nodes are not connected by any path.

### Properties of General Graphs

- **Adjacency**: Two nodes are adjacent if there is an edge directly connecting them.
- **Degree**: The degree of a node is the number of edges connected to it. In directed graphs, nodes have an in-degree (incoming edges) and an out-degree (outgoing edges).
- **Path**: A sequence of edges connecting a series of nodes.
- **Cycle**: A path that starts and ends at the same node without repeating any edges or nodes (except the starting/ending node).
- **Subgraph**: A graph formed from a subset of the nodes and edges of another graph.

### Applications of General Graphs

- **Network Routing**: Graphs are used to represent and solve routing problems in networks (e.g., internet, transportation).
- **Social Networks**: Nodes represent people, and edges represent relationships or interactions.
- **Pathfinding**: Algorithms like A*, Dijkstra’s, and BFS/DFS are used to find paths in graphs.
- **Dependency Resolution**: DAGs are used in scheduling tasks, where nodes represent tasks and edges represent dependencies.

### Representations of General Graphs

- **Adjacency Matrix**: A 2D array where the cell at row i and column j represents the presence (and possibly the weight) of an edge between nodes i and j.
- ![[Screenshot from 2024-05-31 13-31-40.png]]

- **Adjacency List**: An array of lists. The i-th list contains all nodes adjacent to node i.
- ![[Screenshot from 2024-05-31 13-33-39.png]]
- **Edge List**: A list of all edges, each represented by a pair (or triplet if weighted) of nodes.
- ![[Screenshot from 2024-05-31 13-34-43.png]]