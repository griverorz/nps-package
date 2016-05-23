#' Calculation of nps score and estimated standard error 
#' 
#' The signature method \code{score} for the class \code{nps}
#' summarizes and prints information regarding the NPS score.
#' 
#' @param object An object of class \code{nps}
#' @param R Number of bootstrap replications
#' @author Gonzalo Rivero
score.nps <- function(x, se=TRUE, boot=FALSE, R=999) {
    tab <- summary(x)/length(x@values)
    nps <- tab[1] - tab[3]
    if (se) {
        if (!boot) {
            tab <- summary(x)/length(x@values)
            value <- (1 - nps)^2 *tab[1] + (0 - nps)^2*tab[2] + (-1 - nps)^2*tab[3]
            se <- sqrt(value)
        } else {
            se <- sd(npsboot(R, x@values, x@top, x@bottom))
        }
    }

    return(list("Score"=nps,
                "SE"=se,
                "R"=R))
}

setGeneric("score", function(object, ...) standardGeneric("score"))
setMethod("score", signature="nps", function(object, ...) score.nps(object, ...))
