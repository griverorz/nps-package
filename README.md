[![Build Status](https://travis-ci.org/griverorz/nps-package.svg?branch=master)](https://travis-ci.org/griverorz/nps-package)
[![codecov](https://codecov.io/gh/griverorz/nps-package/branch/master/graph/badge.svg)](https://codecov.io/gh/griverorz/nps-package)

# The `nps` package

The `nps` is a package designed to be used as an example for the "R Development"
class at Westat. It presents a number of features that are common in statistical
programming in R like S4 classes, C/C++ integration, or unit testing. It is not
intended for production use.

# Net Promoter Score

The [Net Promoter Score](https://en.wikipedia.org/wiki/Net_Promoter) (registered trademark of Fred Reichheld, Bain & Company,
and Satmetrix) is a widely used measure of customer satisfaction.

The Net Promoter Score is calculated based on responses to a single question:
> How likely is it that you would recommend our company/product/service to a
friend or colleague? 

Respondents can answer in a scale from 0 (Very unlikely) to 10 (Very likely).
Respondents who answered with 9 or 10 are called "Promoters" and respondents who
answered with a value below 6 are called "Detractors". Values 7 and 8 are
labeled "Passives". The NPS is defined as the proportion of Promoters minus the
proportion of Detractors.

Although it has gained considerable popularity, it has also attracted
controversy. 

# Usage

The package provides a function `nps()` that takes a vector of integer values
and two sequences that define the group of promoters and detractors. The
constructor validates the object by checking simple conditions such a non
overlap between the values that define promoters and detractors.

The `summary()` method produces a frequency table with counts for each category. 
```r
x <- nps(sample(0:10, 50, replace=TRUE))
print(x)
summary(x)
```

The user can change the definition of the promoters and detractors categories by
using the `top` and `bottom` arguments in the constructor. 
```r
x <- nps(sample(1:10, 50, replace=TRUE), bottom=1:6)
```

The package provides a function to calculate the score and its standard error
through two methods: an analytical and bootstrap. The bootstrap solution is
implemented through `Rcpp` and `RcppArmadillo`. 
```r
score(x, boot=TRUE, R=999)
```

It is also possible to edit the `nps` object using the `top<-` and `bottom<-`
setters. 
```r
x <- nps(sample(0:10, 50, replace=TRUE), bottom=0:6)
bottom(x) <- 0:5
score(x, boot=TRUE, R=999)
```

# Installation

The package can be installed using the `devtools` package.

```r
install.packages("devtools")
devtools::install_github("griverorz/nps")
```
