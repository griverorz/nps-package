summary.nps <- function(object, ...) {
    outfactor <- rep(NA, length(object@values))
    outfactor[object@values %in% object@top] <- "Promoters"
    outfactor[object@values %in% object@bottom] <- "Detractors"
    outfactor[!object@values %in% c(object@bottom, object@top)] <- "Passive"
    return(table(factor(outfactor, levels=c("Promoters", "Passive", "Detractors"))))
}

#' Summary of NPS values
#' 
#' Summary table of the number of respondents in each category
#' 
#' @param object An object of class \code{nps}
#' @param ... Additional arguments to be passed
#' @return A frequency table with counts for each category
#' @export
setMethod("summary", signature="nps", function(object, ...) summary.nps(object, ...))
