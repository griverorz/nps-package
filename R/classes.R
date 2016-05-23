#' An S4 class to work with NPS
#'
#' @slot values A numeric vector
#' @slot top A numeric vector
#' @slot bottom A numeric vector
setClass("nps",
         slots = list(values="numeric", top="numeric", bottom="numeric"),
         validity=check_nps)


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

#' Instantiate
#'
#' @param x A numeric vector
#' @param top A numeric vector
#' @param bottom A numeric vector
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
