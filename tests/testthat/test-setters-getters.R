context("Setters and getters")

test_that("Setters", {
    x <- nps(0:10)
    expect_error(top(x) <- 9, "Values outside the range")
})

