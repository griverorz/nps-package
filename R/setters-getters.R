#' Replace top values of an NPS vector
#'
#' @export
#' @docType methods
#' @rdname nps-methods
setGeneric("top<-", function(object, value) standardGeneric("top<-"))
setReplaceMethod("top", signature="nps", function(object, value) {
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
setReplaceMethod("bottom", signature="nps", function(object, value) {
                     object@bottom <- value
                     if (validObject(object)) {
                         return(object)
                     }
                 })

#' Get top values of an NPS vector
#'
#' @export
#' @docType methods
#' @rdname nps-methods
setGeneric("top", function(object) standardGeneric("top"))
setMethod("top", signature="nps", function(object) object@top)

#' Get bottom values of an NPS vector
#'
#' @export
#' @docType methods
#' @rdname nps-methods
setGeneric("bottom", function(object) standardGeneric("bottom"))
setMethod("bottom", signature="nps", function(object) object@bottom)


#' Subset an NPS vector
#'
#' @export
#' @docType methods
#' @rdname nps-methods
setMethod("[", signature="nps", function(x, i, j="missing", drop="missing") {
              new("nps", values=x@values[i], top=x@top, bottom=x@bottom)
          })
