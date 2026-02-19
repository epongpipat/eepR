#' get_age_yrs
#' @description calculate age in years
#' @param dob date of birth
#' @param ref_date reference date (default: today's date)
#'
#' @returns
#' @export
#' @importFrom lubridate today
#' @importFrom lubridate interval
#' @importFrom lubridate dyears
#' @examples get_age_years('1776-07-04')
get_age_yrs <- function(dob, ref_date = lubridate::today()) {
  return(round(lubridate::interval(dob, ref_date) / lubridate::dyears(), 4))
}

