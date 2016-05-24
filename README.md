[![Build Status](https://travis-ci.org/griverorz/nps-package.svg?branch=master)](https://travis-ci.org/griverorz/nps-package)
[![codecov](https://codecov.io/gh/griverorz/nps-package/branch/master/graph/badge.svg)](https://codecov.io/gh/griverorz/nps-package)

# The `nps` package

`nps` is a package not intended to be used in a production environment. It was
designed as a tool for the "R Development" class and it explores a number of
features like S4 classes, C/C++ integration, or unit testing in addition to some
programming tools.

# Net Promoter Score

# Usage

The package provides a function `nps()` that takes a vector of integer values
and two sequences that define the group of promoters and detractors. The
constructor validates the object by checking simple conditions such a non
overlap between the values that define promoters and detractors.

The `summary()` method produces a frequency table with counts for each category. 
```
x <- nps(sample(0:10, 50, replace=TRUE))
print(x)
summary(x)
```

The user can change the definition of the promoters and detractors categories by
using the `top` and `bottom` arguments in the constructor. 
```
x <- nps(sample(1:10, 50, replace=TRUE), bottom=1:6)
```

The package provides a function to calculate the score and its standard error
through two methods: an analytical and bootstrap. The bootstrap solution is
implemented through `Rcpp` and `RcppArmadillo`. 
```
score(x, boot=TRUE, R=999)
```

It is also possible to edit the `nps` object using the `top<-` and `bottom<-`
setters. 
```
x <- nps(sample(0:10, 50, replace=TRUE), bottom=0:6)
bottom(x) <- 0:5
score(x, boot=TRUE, R=999)
```

# Installation

The package can be installed using the `devtools` package.

```
install.packages("devtools")
devtools::install_github("griverorz/nps")
```
