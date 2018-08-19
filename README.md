# N Queen threat analysis

Assuming we have an array of chess board co-ordinates that solve the N-Queen Problem.

How can we identify the threat level (number of challenges) for each Queen on the board
without checking each position on the board.

Input is a single array where:

* indices represent X axis
* value represents Y axis

## Notes

1. Correct implementation will result in having to check diagonals first
2. Naive implementation requires checking 4 diagonal vertices
   * To solve for a position: worst case: log(n * n)n
