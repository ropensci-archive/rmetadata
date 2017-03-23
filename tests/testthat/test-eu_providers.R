context("eu_providers")

test_that("eu_providers", {
  tt <- eu_providers(key = Sys.getenv("EUROPEANA_KEY"))
  
  expect_is(tt, "list")
  expect_is(tt$meta, "list")
  expect_is(tt$items, "list")
})
