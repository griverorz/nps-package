// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// npsboot
std::vector<float> npsboot(int R, const std::vector<int>& x, std::vector<int> top, std::vector<int> bottom);
RcppExport SEXP nps_npsboot(SEXP RSEXP, SEXP xSEXP, SEXP topSEXP, SEXP bottomSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< int >::type R(RSEXP);
    Rcpp::traits::input_parameter< const std::vector<int>& >::type x(xSEXP);
    Rcpp::traits::input_parameter< std::vector<int> >::type top(topSEXP);
    Rcpp::traits::input_parameter< std::vector<int> >::type bottom(bottomSEXP);
    __result = Rcpp::wrap(npsboot(R, x, top, bottom));
    return __result;
END_RCPP
}
