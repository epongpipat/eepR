#' @title model2apa
#' @description converts a model to APA format string
#' @concept stats
#' @family model2apa
#' @param m model from \code{lmer()}
#' @param terms specify terms to print in APA format (default: all)
#' @param level specify confidence level (default: 0.95)
#' @param digits specify digit to round statistics (default: 3)
#' @param format specify format (default: html) (options: html, plain)
#' @return Character string with APA-formatted model results.
#' @export
#' @examples
#' # cor.test
#' model2apa(cor.test(carData::Salaries$yrs.since.phd, carData::Salaries$salary), format = 'plain')
#'
#' # lm
#' model2apa(lm(mpg ~ wt, data = mtcars), format = 'plain')
#'
#' # lme
#' model2apa(lmerTest::lmer(Reaction ~ 1 + Days + (1 + Days | Subject), lme4::sleepstudy), format = 'plain')
model2apa <- function(m, terms = 'all', level = 0.95, digits = 3, format = 'html') {
  class <- as.character(attr(m, 'class'))
  valid_classes <- c('htest', 'lm', 'lmerModLmerTest')
  if (!class %in% valid_classes) {
    stop(sprintf('not a valid class (%s). class must be either: %s', class, valid_classes))
  }

  if (class %in% c('htest')) {
    return(cor2apa(m, level = level, digits = digits, format = format))
  } else if (class %in% c('lm')) {
    return(lm2apa(m, terms = terms, level = level, digits = digits, format = format))
  } else if (class %in% c('lmerModLmerTest')) {
    return(lmer2apa(m, terms = terms, level = level, digits = digits, format = format))
  }
}
