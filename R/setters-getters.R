#' Setters 
#'
#' Setter for the top and bottom categories
#'
#' @param object An \code{nps} object
#' @param value The new categories
#' @return An \code{nps} object
#' @name setters
NULL


#' Getters
#'
#' Getter for the top and bottom categories
#'
#' @param object An \code{nps} object
#' @return An \code{nps} object
#' @name getters
NULL


#' @rdname setters
setGeneric("top<-", function(object, value) standardGeneric("top<-"))
setReplaceMethod("top", signature("nps"), function(object, value) {
    object@top <- value
    if (validObject(object)) {
        return(object)
    }
})


#' @rdname setters
setGeneric("bottom<-", function(object, value) standardGeneric("bottom<-"))
setReplaceMethod("bottom", signature("nps"), function(object, value) {
    object@bottom <- value
    if (validObject(object)) {
        return(object)
    }
})


#' @rdname getters
setGeneric("top", function(object) standardGeneric("top"))
setMethod("top", signature("nps"), function(object) object@top)


#' @rdname getters
setGeneric("bottom", function(object) standardGeneric("bottom"))
setMethod("bottom", signature="nps", function(object) object@bottom) 


#' Subset an NPS vector
#'
#' @param x An \code{nps} object
#' @param i An index for the selection
#' @rdname extract-methods
#' @export
setMethod("[", signature("nps"), function(x, i) {
    new("nps", values=x@values[i], top=x@top, bottom=x@bottom)
})
