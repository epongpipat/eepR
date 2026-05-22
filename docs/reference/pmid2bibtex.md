# pmid2bibtex

pmid2bibtex

## Usage

``` r
pmid2bibtex(pmid, key_as_first_author_year = TRUE)
```

## Arguments

- pmid:

  PubMed identifier

- key_as_first_author_year:

  logical, whether to use first-author-year as the BibTeX key

## Value

Character string containing BibTeX citation text.

## See also

Other PubMed helpers:
[`pmcid2pdf()`](https://ekarinpongpipat.com/eepR/reference/pmcid2pdf.md),
[`pmid2abstract()`](https://ekarinpongpipat.com/eepR/reference/pmid2abstract.md),
[`pmid2doi()`](https://ekarinpongpipat.com/eepR/reference/pmid2doi.md),
[`pmid2pmcid()`](https://ekarinpongpipat.com/eepR/reference/pmid2pmcid.md)

## Examples

``` r
if (FALSE) { # \dontrun{
pmid2bibtex(33317393)
} # }
```
