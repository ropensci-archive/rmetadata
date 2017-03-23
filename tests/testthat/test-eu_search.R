context("eu_search")

test_that("eu_search", {
  tt <- eu_search(query = "Mona Lisa", key = Sys.getenv("EUROPEANA_KEY"))
  
  expect_is(tt, "list")
  expect_is(tt$apikey, "character")
  expect_equal(tt$success, TRUE)
  expect_is(tt$requestNumber, "integer")
  expect_is(tt$itemsCount, "integer")
  expect_is(tt$totalResults, "integer")
  expect_is(tt$items, "list")
  expect_is(tt$items[[1]], "list")
  expect_is(tt$items[[2]], "list")  
})
