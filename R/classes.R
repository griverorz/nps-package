#' Score calculation for NPS
#'
#' A collection of tools to represent and operate with NPS data
#'
#' @name nps-class
#' @aliases nps-class summary
#' @docType class
#' @section Objects from the Class: Objects can be created by calls of the form
#' \code{new("nps", ...)}.
#' @author Gonzalo Rivero
#'
#' @keywords classes

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

setClass("nps",
         slots = list(values="numeric", top="numeric", bottom="numeric"),
         validity=check_nps)

setMethod("show", signature="nps", function(object) {
              cat("Net Promoter Score data\n")
              cat("Top categories:",  object@top, "\n")
              cat("Bottom categories:",  object@bottom, "\n")
              print(object@values)
          })

nps <- function(x, top=9:10, bottom=0:6) {
    inst <- new("nps", values=x, top=top, bottom=bottom)
    return(inst)
}


#' Replace top values of an NPS vector
#'
#' @export
#' @docType methods
#' @rdname nps-methods
setGeneric("top<-", function(object, value) standardGeneric("top<-"))
setReplaceMethod("top", "nps", function(object, value) {
                     object@top <- value
                     if (validObject(object)) {
                         return(object)
                     }
                 })

#' Replace bottom values of an NPS vector
#'
#' @export
#' @docType methods
#' @rdname nps-methods
setGeneric("bottom<-", function(object, value) standardGeneric("bottom<-"))
setReplaceMethod("bottom", "nps", function(object, value) {
                     object@bottom <- value
                     if (validObject(object)) {
                         return(object)
                     }
                 })

#' Subset an NPS vector
#'
#' @export
#' @docType methods
#' @rdname nps-methods
setMethod("[", "nps", function(x, i, j="missing", drop="missing") {
              new("nps", values=x@values[i], top=x@top, bottom=x@bottom)
          })


#' Get top values of an NPS vector
#'
#' @export
#' @docType methods
#' @rdname nps-methods
setGeneric("top", function(object) standardGeneric("top"))
setMethod("top", "nps", function(object) object@top)

#' Get bottom values of an NPS vector
#'
#' @export
#' @docType methods
#' @rdname nps-methods
setGeneric("bottom", function(object) standardGeneric("bottom"))
setMethod("bottom", "nps", function(object) object@bottom)

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
