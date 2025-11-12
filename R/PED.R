#' @title
#' Pairwise Euclidean distances between two sets of points in a euclidean space
#' @details
#' Function calculates a matrix of pairwise Euclidean distances between two inputs. Each input can be
#' a numeric vector, treated as one dimensional points, or a numeric matrix or data frame
#' with rows as points and columns as features or dimensions. The number of columns (dimensions) must MATCH!!
#'
#'
#' @param x A numeric vector or a numeric matrix or a data frame. Rows are points.
#'   If a vector is supplied it is treated as a column matrix of dimension 1.
#'   Justification for naming: Named `x` to follow standard math notation
#' @param y A numeric vector or a numeric matrix or a data frame. Same previous rules apply as `x`
#'   Justification for naming: Named `y` to follow standard math notation
#' @param na_rm Logical. If TRUE drop any rows in `x` or `y` that contain NA or non finite values
#'   before computing distances. If FALSE such values cause an error. Default TRUE.
#'   Named `na_rm` to reflect the common base R notation
#'
#' @return Numeric matrix of size n by m, where n is the number of kept rows in `x`
#'   and m is the number of kept rows in `y`.
#'
#' @examples
#' # vectors as one dimensional points
#' pairwise_euclid(c(0,1,3), c(2,5))
#'
#' # with NA rows dropped
#' X <- rbind(c(0,0), c(NA, 1), c(2,0))
#' Y <- rbind(c(0,1), c(2,2))
#' pairwise_euclid(X, Y, na_rm = TRUE)
#'
#' # Example 2: two dimensional points stored in matrices
#' X <- rbind(c(0, 0), c(1, 1), c(2, 0))
#' Y <- rbind(c(0, 1), c(2, 2))
#' pairwise_euclid(X, Y)
#' @export
pairwise_euclid <- function(x, y, na_rm = TRUE) {
  # Coercion to Matrix
  to_mattting <- function(a) {
    if (is.data.frame(a)) a <- as.matrix(a)
    if (is.null(dim(a))) a <- matrix(as.numeric(a), ncol = 1)
    if (!is.numeric(a)) stop("x and y must be either numeric vectors, numeric matrices, or data frames of numerics!!! Please check your data input.")
    a
  }
  X <- to_mattting(x)
  Y <- to_mattting(y)
  #Handling missing values
  if (any(!is.finite(X)) || any(!is.finite(Y))) {
    if (isTRUE(na_rm)) {
      keep_x <- stats::complete.cases(X)
      keep_y <- stats::complete.cases(Y)
      X <- X[keep_x, , drop = FALSE]
      Y <- Y[keep_y, , drop = FALSE]
    } else {
      stop("Missing or non finite values found. Set na_rm = TRUE to drop rows with such values.")
    }
  }
  if (nrow(X) == 0L || nrow(Y) == 0L) stop("No rows left after NA handling")
  if (ncol(X) != ncol(Y)) stop("x and y must have the same number of columns")

  # Efficient Euclidean distance using cross terms: ||x - y||^2 = ||x||^2 + ||y||^2 - 2 x.y
  x2 <- rowSums(X^2)
  y2 <- rowSums(Y^2)
  D2 <- outer(x2, y2, "+") - 2 * (X %*% t(Y))
  D2[D2 < 0] <- 0 # Safety numerically
  sqrt(D2)
}
