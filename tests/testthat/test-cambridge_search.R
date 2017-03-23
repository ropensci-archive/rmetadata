context("cambridge_search")

test_that("cambridge_search", {
  tt <- cambridge_search(query = "history")
  
  expect_is(tt, "data.frame")
  expect_is(tt$creator, "list")
  expect_is(tt$identifier, "list")
  expect_is(tt$title, "list")
  expect_is(tt$bibliographicCitation, "list")
  expect_is(tt$url, "list")
  expect_is(tt$journalTitle, "list")
  expect_is(tt$volume, "list")
  expect_is(tt$issueNo, "list")
  expect_is(tt$pages, "list")
  expect_is(tt$year, "list")  
})
