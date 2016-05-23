#' Setters 
#'
#' @param object An \code{nps} object
#' @param value A vector with the values of the top or bottom category
#' @name setters
NULL

#' Getters
#'
#' @param object An \code{nps} object
#' @name getters
NULL


#' Change the values corresponding to the "Promoters" category
#'
#' @rdname setters
#' @export
setGeneric("top<-", function(object, value) standardGeneric("top<-"))
setReplaceMethod("top", signature="nps", function(object, value) {
                     object@top <- value
                     if (validObject(object)) {
                         return(object)
                     }
                 })


#' Change the values corresponding to the "Detractors" category
#'
#' @rdname setters
#' @export
setGeneric("bottom<-", function(object, value) standardGeneric("bottom<-"))
setReplaceMethod("bottom", signature="nps", function(object, value) {
                     object@bottom <- value
                     if (validObject(object)) {
                         return(object)
                     }
                 })

#' Retrieve the values corresponding to the "Promoters" category
#'
#' @rdname getters
#' @export
setGeneric("top", function(object) standardGeneric("top"))
setMethod("top", signature="nps", function(object) object@top)

#' Retrieve the values corresponding to the "Promoters" category
#'
#' @rdname getters
#' @export
setGeneric("bottom", function(object) standardGeneric("bottom"))
setMethod("bottom", signature="nps", function(object) object@bottom)


#' Subset an NPS vector
#'
#' @param x An \code{nps} object
#' @param i An index for the selection
setMethod("[", signature="nps", function(x, i) {
              new("nps", values=x@values[i], top=x@top, bottom=x@bottom)
          })
