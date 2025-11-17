
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PairwiseEucleadianDistance

<!-- badges: start -->

This is a minimal working example of my first R Package for STAT545!
<!-- badges: end -->

The goal of PairwiseEucleadianDistance is to calculate a matrix of
pairwise Euclidean distances between two inputs. Each input can be a
numeric vector, treated as one dimensional points, or a numeric matrix
or data frame with rows as points and columns as features or dimensions.
Make sure that the number of columns (dimensions) match.

## Installation

You can install the development version of PairwiseEucleadianDistance
from
[GitHub](https://github.com/stat545ubc-2025/Pairwise-Eucleadian-Distance)
with:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2025/Pairwise-Eucleadian-Distance")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(PairwiseEucleadianDistance)
## basic example code
X <- rbind(c(0, 0), c(1, 5), c(2, 0))
Y <- rbind(c(0, 1), c(2, 4))
pairwise_euclid(X, Y)
#>          [,1]     [,2]
#> [1,] 1.000000 4.472136
#> [2,] 4.123106 1.414214
#> [3,] 2.236068 4.000000
```
