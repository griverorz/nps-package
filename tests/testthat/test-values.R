context("NPS calculation")

test_that("Malformed NPS data", {
    expect_error(nps(-1), "Values outside the range")
    expect_error(nps(11), "Values outside the range")
    expect_error(nps(0, bottom=1:6), "Values outside the range")
    expect_error(nps(10, top=9), "Values outside the range")
    expect_error(nps(0, bottom=0:10, top=0:10), "Top and bottom must not overlap")
})

test_that("NPS calculation", {
    expect_true(all(score(nps(0)) == c(-1, 0)))
    expect_true(all(score(nps(10)) == c(1, 0)))
})
