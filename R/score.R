#' Calculation of NPS and estimated standard error 
#' 
#' Calculation of the score and its standard error. The function allows for the calculation of the standard error using both its analytical derivation and through non-parametric bootstrap.
#' 
#' @param x An object of class \code{nps}
#' @param boot A logical flag for whether to use bootstrap for the calculation of the standard error. Default is FALSE.
#' @param R Number of bootstrap replications
#' @return A vector with the estimated score and the standard error
#' @export
#' @examples
#'
#' \dontrun{score(x, boot=TRUE, R=999)}
score.nps <- function(x, boot=FALSE, R=999) {
    tab <- as.vector(summary(x)/length(x@values))
    score <- tab[1] - tab[3]
    if (!boot) {
        value <- (1-score)^2*tab[1] + (0-score)^2*tab[2] + (-1-score)^2*tab[3]
        se <- sqrt(value)
    } else {
        se <- sd(npsboot(R, x@values, x@top, x@bottom))
    }
    
    ans <- cbind(score, se, if (boot) R)
    dimnames(ans) <- list("", c("Score", "SE", if (boot) "Reps"))
    return(ans)
}

setGeneric("score", function(object, ...) standardGeneric("score"))
setMethod("score", signature="nps", function(object, ...) score.nps(object, ...))
