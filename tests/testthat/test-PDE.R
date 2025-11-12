test_that("shape of the output matches n by m for vectors", {
  x <- c(0,1,3); y <- c(2,5,7)
  D <- pairwise_euclid(x, y)
  expect_equal(dim(D), c(length(x), length(y)))
})

test_that("one dimensional equals absolute differences", {
  set.seed(1)
  x <- rnorm(4); y <- rnorm(3)
  D <- pairwise_euclid(x, y)
  expect_equal(D, abs(outer(x, y, "-")), tolerance = 1e-12)
})

test_that("NA handling works when na_rm is TRUE and errors when FALSE", {
  X <- rbind(c(0,0), c(NA, 1), c(2,0))
  Y <- rbind(c(0,1), c(2,2))
  D <- pairwise_euclid(X, Y, na_rm = TRUE)
  expect_equal(dim(D), c(2, 2))  # the NA row should be dropped

  expect_error(pairwise_euclid(X, Y, na_rm = FALSE))
})
test_that("zero length input errors clearly", {
  # x (first input) has zero rows
  expect_error(
    pairwise_euclid(numeric(0), 1:3),
    "No rows left",
    fixed = FALSE
  )
  # y (second input) has zero rows
  expect_error(
    pairwise_euclid(1:3, numeric(0)),
    "No rows left",
    fixed = FALSE
  )
  # both inputs have zero rows
  expect_error(
    pairwise_euclid(numeric(0), numeric(0)),
    "No rows left",
    fixed = FALSE
  )
})
