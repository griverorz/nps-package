context("NPS calculation")

test_that("NPS calculation", {
    expect_true(all(score(nps(0)) == c(-1, 0)))
    expect_true(all(score(nps(10)) == c(1, 0)))
})
