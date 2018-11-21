
# NetSetStat

NetSetStat repository includes a set of R functions to statistically characterize sets of nodes within interaction networks. These functions rely on the igraph package.

## joincomp

This function takes as input a set of nodes that induces an unconnected subgraph and returns and larger set of nodes that constitutes a connected subgraph. It guarantees that this larger set of nodes has the smaller number of elements as possible.

## joincompt

This function is similar to joincomp, but if two of the nodes of the initial set are separated by a shortest path with length greater than a defined threshold (given as input) they will not be connected in the final output.

## bridge_score

This function quantifies for every node in a network its relevance in connecting two other nodes (provided as inputs) through short paths of length 2, 3 or 4. It counts the fraction of paths of length 2, 3 or 4 linking the two input nodes that contain a given node. These fractions for each length are used in a weighted sum where paths of length 2 have weigth 1, paths of length 3 have weigth 0.5 and paths of length 4 have weigth 0.25.

## specific_neighbors

This function applies an hypergeometric test to each node in a network in order to check if the number of direct interactions to an input set of nodes is higher than expected by chance, taking into account the degree of each node. In other words, it tests if a given node is a specific neighbour of an input set of nodes.

## within_connectivity

This function quantifies the number of direct interactions between the members of an input set of nodes and tests if this connectivity is higher than expected by chance using three different methods:
  1.  randomly shuffling the identity of the set nodes
  2.  randomly shuffling the network edges maintaining node degree
  3.  using an hypergeometric test
  
## between_connectivity

Function similar to within_connectivity but to quantify the number of direct interactions between two sets of nodes.