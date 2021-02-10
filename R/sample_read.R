#'  Read external csv data
#'
#'  This is an internal simple function that reads a file when it exists and it converts it into a tibble
#'
#' @param path to the file
#'
#' @return a \code{tibble}
#'
#' @export
#'
#' @importFrom readr read_csv
#'
#' @examples
#' path =  system.file("extdata","accident_2013.csv.bz2",package="testFars")
#' sample_read(path)

sample_read <- function(path) {
  read_csv(path)
}
