% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{fars_map_state}
\alias{fars_map_state}
\title{fars_map_state}
\usage{
fars_map_state(state.num, year)
}
\arguments{
\item{state.num}{a number representing the state of the US for which the plot will be produced}

\item{year}{the year for which the data will be plotted}
}
\value{
a plot of the state with points on it indicating the geographic coordinates of the fatalities registered in the year.
}
\description{
This is a function that produces a plot of the locations where the fatalities occurred per year and state.
}
\details{
This is a function that calls other functions in this package and first makes a filename based on the year provided in the parameter, reads the corresponding file and if the provided state (as a number) exists in the data, filters the data specific for that state, assigns NA values to longitude values over 900 and latitude values over 90, plots a map of the state and places points for each row in the dataset (each fatality) on the map.
}
\note{
the last one of the examples will produce an error because there is no 100 state in th US.

If we happen to otherwise take a year and a state in which no accidents were observed that year (the returned table has no rows) a message that indicates tht there are no accidents to plot will be displayed, no plot is returned.
}
\examples{
fars_map_state(1,2015)
fars_map_state(51,2013)
fars_map_state(100,2015)

}
