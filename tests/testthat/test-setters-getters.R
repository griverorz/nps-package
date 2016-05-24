context("Setters and getters")

test_that("Getters", {
    x <- nps(0:10)
    expect_true(all(top(x) == 9:10))
    expect_true(all(bottom(x) == 0:6))

    x <- nps(1:10, top=8:10, bottom=1:6)
    expect_true(all(top(x) == 8:10))
    expect_true(all(bottom(x) == 1:6))
})

test_that("Setters", {
    x <- nps(0:10)
    expect_error(top(x) <- 9, "Values outside the range")
    top(x) <- 8:10
    expect_true(all(top(x) == 8:10))
})

