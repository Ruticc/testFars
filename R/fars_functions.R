

#'  fars_read is a function that reads a csv table.
#'
#'  This is an internal simple function that reads a file when it exists and it converts it into a tibble
#'
#' @param filename The name of the file that needs to be read.
#'
#' @return it returns the datafile that has been read transformed into a tibble
#'
#' @importFrom dplyr tbl_df
#' @importFrom readr read_csv
#'
#' @examples
#'	fars_read(\code{filename})
#'
#' @note if the function is provided a filename that is not available it returns an error. One needs to be sure that one is in the right directory or that the provided filenames exist.

fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE,quote="")
        })
        dplyr::tbl_df(data)
}


#'  make_filename is a function that creates a filename based on the input of a year
#'
#'  This is an internal simple function that produces and export a name for the file specifically indicated for the US National Highway Traffic Safety Administration's Fatality Analysis Reporting System,
#'
#' @param year The only parameter of this function is is the year for which the datafile name will be creatd
#'
#' @return a string name that includes the year but it is specifically containing a string starting with "accident" and it is a compressed bz2 csv file"
#'
#' @examples
#'	make_filename(2016)
#'
#'

make_filename <- function(year) {
        year <- as.integer(year)
        sprintf("accident_%d.csv.bz2", year)
}


#'  fars_read_years is a function that will select for each year that is provided in the parameter years
#'
#'  This is an internal function that reads for each year provided in the parameter years the data, creates a variable called year for each data that is read which receives the corresponding year and selects the columns MONTH and year.
#'
#' @param years it is a vector of the years for which the data will be read
#'
#' @return a list in which elemnt is a tibble for each year containing MONTH and year (each row is a fatality).
#'
#' @importFrom dplyr select mutate
#' @importFrom magrittr '%>%'
#'
#' @examples
#'	fars_read_years(c(2014,2013))
#'	fars_read_years(c(2014,2025)) # the second element will be NULL

#' @note if the provided year is not a number but a string for example or it is not available (a year in the future) the function returns invalid year and can not read the data it returns an empty value for that list element


fars_read_years <- function(years) {
        lapply(years, function(year) {
                file <- make_filename(year)
                MONTH <- NULL
                tryCatch({
                        dat <- fars_read(file)
                        dplyr::mutate(dat, year = year) %>%
                                dplyr::select(MONTH, year)
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}

#'  fars_summarize_years is a function that summarizes in the format of a table how many fatalities were registered per month and year, and the years for which the data is summarized is provided as a parameter
#'
#'
#' @param years it is a vector of the years for which the data will be read and summarized
#'
#' @return a tibble in which the first column is the variable MONTH indicated by a number from 1:12, and each subsequent column corresponds to a variable with the name of the year provided int he parameter. In this case each of the years include data forthe number of fatalitis per month
#'
#' @importFrom dplyr bind_rows group_by summarize
#' @importFrom tidyr spread
#' @importFrom magrittr '%>%'
#'
#' @examples
#'	fars_summarize_years(c(2013:2015))
#'	fars_summarize_years(2013)
#'	fars_summarize_years(c(2014,2025))
#'
#'	@note when the year is not available in the dataset it will produce a warning and just produce the exported tibble with the valid years.
#'
#' @export

fars_summarize_years <- function(years) {
        year <- MONTH <- n <- NULL
        dat_list <- fars_read_years(years)
        dplyr::bind_rows(dat_list) %>%
                dplyr::group_by(year, MONTH) %>%
                dplyr::summarize(n = dplyr::n()) %>%
                tidyr::spread(year, n)
}


#' fars_map_state
#'
#' This is a function that produces a plot of the locations where the fatalities occurred per year and state.
#'
#' @details
#' This is a function that calls other functions in this package and first makes a filename based on the year provided in the parameter, reads the corresponding file and if the provided state (as a number) exists in the data, filters the data specific for that state, assigns NA values to longitude values over 900 and latitude values over 90, plots a map of the state and places points for each row in the dataset (each fatality) on the map.
#'
#' @param state.num a number representing the state of the US for which the plot will be produced
#' @param year the year for which the data will be plotted
#'
#'  @return a plot of the state with points on it indicating the geographic coordinates of the fatalities registered in the year.
#'
#' @importFrom maps map
#' @importFrom dplyr filter
#' @importFrom graphics points
#'
#' @examples
#'	fars_map_state(1,2015)
#'	fars_map_state(51,2013)
#'	fars_map_state(100,2015)
#'
#' @note the last one of the examples will produce an error because there is no 100 state in th US.
#' @note If we happen to otherwise take a year and a state in which no accidents were observed that year (the returned table has no rows) a message that indicates tht there are no accidents to plot will be displayed, no plot is returned.
#' @export


fars_map_state <- function(state.num, year) {
        filename <- make_filename(year)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)

        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        STATE <- NULL
        data.sub <- dplyr::filter(data, STATE == state.num)
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                graphics::points(LONGITUD, LATITUDE, pch = 46)
        })
}
