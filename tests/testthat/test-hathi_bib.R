context("hathi_bib")

test_that("hathi_bib", {
  tt <- hathi_bib(oclc = 424023)

  expect_is(tt, "list")
  expect_is(tt$records, "list")
  expect_is(tt$items, "data.frame")
  expect_is(tt$items$orig, "character")
  expect_is(tt$items$fromRecord, "character")
  expect_is(tt$items$htid, "character")
  expect_is(tt$items$itemURL, "character")
  expect_is(tt$items$rightsCode, "character")
  expect_is(tt$items$lastUpdate, "character")
  expect_is(tt$items$enumcron, "logical")
  expect_is(tt$items$usRightsString, "character") 
})
