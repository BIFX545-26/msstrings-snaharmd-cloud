# MSstrings


MSstrings is a package that will read Spectronaut-formatted peptides
with or without protein modification and display them nicely.

# Installation

MSstrings can be installed Github using the following command:

``` r
devtools::install_github('https://github.com/BIFX545-26/msstrings-snaharmd-cloud')
```

# Example

This package comes with a sample dataset, which we import and display
below.

``` r
library(MSstrings)

data("MSfrags")
parse_mods(MSfrags)
```

    22-letter AAString object
    seq: MDYQVSSPIYDINYYTSEPCQK
              |
              Glycosylation

    28-letter AAString object
    seq: LLPPLYSLVFIFGFVGNMLVILILINCK
                          |
                          Oxidation

    64-letter AAString object
    seq: SMTDIYLLNLAISDLFFLLTVPFWAHYAAAQWDFGNTMCQLLTGLYFIGFFSGIFFIILLTIDR
              |                        |
              |                        Deamidation
              Acetylation

    28-letter AAString object
    seq: TVTFGVVTSVITWVVAVFASLPGIIFTR
      No modifications
