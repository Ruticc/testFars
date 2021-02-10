context("Just testing functionality of functions in testFars")



test_that("state.num argument in fars_map_state is a number", {
  statenum <- sample(1:100,size=1,replace=FALSE)
  statenum <- as.integer(as.character(statenum))
  testingstatenumint <- function(state.num) {fars_map_state(state.num = statenum,year=2013)

  }

  expect_that(testingstatenumint(state.num = statenum), is_a("integer"))
  statenum <- sample(letters,size=3)
  expect_that(testingstatenumint(state.num = statenum), throws_error())

})


test_that(paste0("if as.integer(years) is not a valid year with four numbers between 2013 and 2015 in the function fars_summarize_years an error is returned"),{

  rangevalidyears <- 2013:2015
  years <- sample(rangevalidyears,size=sample.int(1:length(rangevalidyears),replace=FALSE),replace=FALSE)
  expect_that(names(fars_summarize_years(years))[1],equals("MONTH"))

  years <- sample(1950:2000,size=sample.int((1:length(1950:2000)),replace=FALSE),replace=FALSE)
  expect_that(fars_summarize_years(years), throws_error())
})


