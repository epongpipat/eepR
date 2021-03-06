#' @title pmid2doi
#' @concept references_pubmed
#' @param pmid
#'
#' @return
#' @export
#'
#' @examples
pmid2doi <- function(pmid) {
  require(dplyr)
  require(stringr)
  require(rvest)
  require(glue)
  glue("https://pubmed.ncbi.nlm.nih.gov/{pmid}") %>%
    read_html(.) %>%
    html_node(".identifiers") %>%
    html_node(".identifier.doi") %>%
    html_node(".id-link") %>%
    html_text() %>%
    str_remove_all(., "\n") %>%
    str_squish()
}

#' @title pmid2pmcid
#' @concept references_pubmed
#' @param pmid
#'
#' @return
#' @export
#'
#' @examples
pmid2pmcid <- function(pmid) {
  require(dplyr)
  require(stringr)
  require(rvest)
  require(glue)
  html_pmcid <- glue("https://pubmed.ncbi.nlm.nih.gov/{pmid}") %>%
    read_html(.) %>%
    html_node(".identifiers") %>%
    html_node(".identifier.pmc")
  if (is.na(html_pmcid)) {
    pmcid <- NULL
    warning("No PMCID Found")
  } else {
    pmcid <- html_pmcid %>%
      html_node(".id-link") %>%
      html_text() %>%
      str_remove_all(., "\n") %>%
      str_squish()
  }
  return(pmcid)

}

#' @title pmid2bibtex
#' @concept references_pubmed
#' @param pmid
#' @param key_as_first_author_year
#'
#' @return
#' @export
#'
#' @examples
pmid2bibtex <- function(pmid, key_as_first_author_year = TRUE) {
  require(dplyr)
  require(stringr)
  require(rvest)
  require(glue)
  bibtex <- glue("http://www.bioinformatics.org/texmed/cgi-bin/list.cgi?PMID={pmid}") %>%
    read_html(.) %>%
    html_node("body") %>%
    html_children() %>%
    html_text() %>%
    str_subset(., "@")

  # clean
  bibtex <- str_sub(bibtex, str_locate(bibtex, "@")[1], str_count(bibtex)) %>%
    str_replace_all(., "\n\n", "\n")

  # replace key
  if (isTRUE(key_as_first_author_year)) {
    first_author <- bibtex %>%
      str_split(., ",") %>%
      unlist() %>%
      str_subset(., "Author") %>%
      str_split(., '"') %>%
      unlist() %>%
      last() %>%
      tolower()
    year <- bibtex %>%
      str_split(., ",") %>%
      unlist() %>%
      str_subset(., "Year") %>%
      str_split(., "=") %>%
      unlist() %>%
      last() %>%
      str_remove_all(., '"')
    bibtex <- str_replace(bibtex, paste0('[[{]]pmid', pmid, ","), paste0('{', first_author, year, ","))
  }

  # add doi
  doi <- pmid2doi(pmid)
  bibtex <- str_replace(bibtex, "\n\\}\n", paste0(',\n   doi="', doi, '"\n\\}\n'))
  bibtex <- str_replace(bibtex, "\n\\}\n", paste0(',\n   url="https://doi.org/', doi, '"\n\\}\n'))
  return(bibtex)
}

#' @title pmcid2pdf
#' @concept references_pubmed
#' @param pmcid
#'
#' @return
#' @export
#'
#' @examples
pmcid2pdf <- function(pmcid) {
  require(dplyr)
  require(stringr)
  require(rvest)
  require(glue)
  glue("https://www.ncbi.nlm.nih.gov/pmc/articles/{pmcid}") %>%
    read_html(.) %>%
    html_node(".format-menu") %>%
    html_node("ul") %>%
    html_children() %>%
    html_children() %>%
    html_attr("href") %>%
    str_subset(., ".pdf") %>%
    paste0("https://www.ncbi.nlm.nih.gov", .)
}

#' @title pmid2abstract
#' @concept references_pubmed
#' @param pmid
#'
#' @return
#' @export
#'
#' @examples
pmid2abstract <- function(pmid) {
  require(dplyr)
  require(stringr)
  require(rvest)
  require(glue)
  glue("https://pubmed.ncbi.nlm.nih.gov/{pmid}") %>%
    read_html(.) %>%
    html_node(".abstract-content.selected") %>%
    html_text() %>%
    str_remove_all(., "\\n") %>%
    str_squish()
}
