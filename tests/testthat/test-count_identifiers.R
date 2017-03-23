context("count_identifiers")

test_that("count_identifiers", {
  tt <- count_identifiers(provider="datacite")
  
  expect_is(tt, "data.frame")
  expect_is(tt$provider, "factor")
  expect_is(tt$count, "factor")
})
