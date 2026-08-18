#' @title model2apa
#' @description converts a model to APA format string
#' @concept stats
#' @family model2apa
#' @param m model from \code{lmer()}, \code{lm()}, \code{cor.test()}, or \code{multcomp::glht()}
#' @param terms specify terms to print in APA format (default: all)
#' @param level specify confidence level (default: 0.95)
#' @param digits specify digit to round statistics (default: 3)
#' @param format specify format (default: html) (options: html, plain)
#' @param test statistical test for \code{glht} models. Options are "t" (default) for t-tests and "F" for joint F-tests.
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
#'
#' # glht (t-test)
#' model_fit <- lm(salary ~ rank + discipline, data = carData::Salaries)
#' c <- gen_contrast_ss(model_fit, x = "rank")[-1, ]
#' glht_obj <- multcomp::glht(model_fit, c)
#' model2apa(glht_obj, test = 't', format = 'plain')
model2apa <- function(m, terms = 'all', level = 0.95, digits = 3, format = 'html', test = c('t', 'F')) {
  test <- match.arg(test)
  class <- as.character(attr(m, 'class'))
  valid_classes <- c('htest', 'lm', 'lmerModLmerTest', 'glht', 'summary.glht')
  if (!any(class %in% valid_classes)) {
    stop(sprintf('not a valid class (%s). class must be one of: %s', paste(class, collapse = ", "), paste(valid_classes, collapse = ", ")))
  }

  if (any(class %in% c('htest'))) {
    return(cor2apa(m, level = level, digits = digits, format = format))
  } else if (any(class %in% c('lm'))) {
    return(lm2apa(m, terms = terms, level = level, digits = digits, format = format))
  } else if (any(class %in% c('lmerModLmerTest'))) {
    return(lmer2apa(m, terms = terms, level = level, digits = digits, format = format))
  } else if (any(class %in% c('glht', 'summary.glht'))) {
    return(glht2apa(m, terms = terms, level = level, digits = digits, format = format, test = test))
  }
}
