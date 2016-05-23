#' Check validity of an \code{nps} object
#'
#' @param object A \code{nps} instance
check_nps <- function(object) {
    errors <- character()
    if (is.null(object)) {
        msg <- paste("Cannot be null")
        errors <- c(errors, msg)
    }
    if (any(is.na(object@top)) | any(is.na(object@bottom))) {
        msg <- paste("Missing values not allowed in definitions")
        errors <- c(errors, msg)
    }
    
    valobj <- object@values[!is.na(object@values)]
    if (any(valobj > max(object@top) | any(valobj < min(object@bottom)))) {
        msg <- paste("Values outside the range")
        errors <- c(errors, msg)
    }

    if (length(errors) == 0) TRUE else errors
}

#' An S4 class to work with NPS data
#'
#' @slot values A numeric vector with the answer values
#' @slot top A numeric vector with the values in the "Promoters" category
#' @slot bottom A numeric vector with the values in the "Detractors" category
setClass("nps",
         slots = list(values="numeric", top="numeric", bottom="numeric"),
         validity=check_nps)

#' Instantiate an \code{nps} object
#'
#' @param x A numeric vector with the answer values
#' @param top A numeric vector with the values in the "Promoters" category
#' @param bottom A numeric vector with the values in the "Detractors" category
#' @export
#' @examples
#' nps(sample(0:10, size=100, replace=TRUE))
nps <- function(x, top=9:10, bottom=0:6) {
    inst <- new("nps", values=x, top=top, bottom=bottom)
    return(inst)
}

setMethod("show", signature="nps", function(object) {
              cat("Net Promoter Score data\n")
              cat("Top categories:",  object@top, "\n")
              cat("Bottom categories:",  object@bottom, "\n")
              print(object@values)
          })
