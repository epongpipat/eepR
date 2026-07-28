# Extract Interaction Terms Involving a Predictor

Extract Interaction Terms Involving a Predictor

## Usage

``` r
extract_interaction_terms(model, predictor)
```

## Arguments

- model:

  A fitted model object.

- predictor:

  Character string of the focal predictor name.

## Value

A named character vector of term labels representing
interaction/polynomial terms involving the predictor. The names
correspond to the moderator variables.
