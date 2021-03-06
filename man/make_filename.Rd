% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{make_filename}
\alias{make_filename}
\title{make_filename is a function that creates a filename based on the input of a year}
\usage{
make_filename(year)
}
\arguments{
\item{year}{The only parameter of this function is is the year for which the datafile name will be creatd}
}
\value{
a string name that includes the year but it is specifically containing a string starting with "accident" and it is a compressed bz2 csv file"
}
\description{
This is an internal simple function that produces and export a name for the file specifically indicated for the US National Highway Traffic Safety Administration's Fatality Analysis Reporting System,
}
\examples{
make_filename(2016)


}
