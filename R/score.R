#' Calculation of NPS and estimated standard error 
#' 
#' Calculation of the score and its standard error. The function allows for the calculation of the standard error using both its analytical derivation and through non-parametric bootstrap.
#' 
#' @param object An object of class \code{nps}
#' @param boot A logical flag for whether to use bootstrap for the calculation of the standard error. Default is FALSE.
#' @param R Number of bootstrap replications
#' @param ... Additional arguments (currently not used)
#' @return A vector with the estimated score and the standard error
#' @rdname score
#' @export
#' @examples
#'
#' \dontrun{score(x, boot=TRUE, R=999)}
setGeneric("score", function(object, ...) standardGeneric("score"))

#' @rdname score
setMethod("score",
          signature("nps"),
          function(object, boot=FALSE, R=999, ...) {
              tab <- as.vector(summary(object)/length(object@values))
              score <- tab[1] - tab[3]
              if (!boot) {
                  value <- (1-score)^2*tab[1] + (0-score)^2*tab[2] + (-1-score)^2*tab[3]
                  se <- sqrt(value)
              } else {
                  se <- sd(npsboot(R, object@values, object@top, object@bottom))
              }
              
              ans <- cbind(score, se, if (boot) R)
              dimnames(ans) <- list("", c("Score", "SE", if (boot) "Reps"))
              return(ans)
          })

