#' Summary of NPS values
#' 
#' The signature method \code{summary} for the class \code{nps}
#' summarizes and prints information regarding the NPS score.
#' 
#' @param object An object of class \code{nps}
#' @author Gonzalo Rivero
summary.nps <- function(x, ...) {
    outfactor <- rep(NA, length(x@values))
    outfactor[x@values %in% x@top] <- "Promoters"
    outfactor[x@values %in% x@bottom] <- "Detractors"
    outfactor[!x@values %in% c(x@bottom, x@top)] <- "Passive"
    return(table(factor(outfactor, levels=c("Promoters", "Passive", "Detractors"))))
}

setMethod("summary", signature="nps", function(object, ...) summary.nps(object, ...))

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
