#include <RcppArmadillo.h>
#include <vector>
#include <RcppArmadilloExtensions/sample.h>

// [[Rcpp::depends(RcppArmadillo)]]
using namespace Rcpp;

float cppnps(const std::vector<int> &x,
	     std::vector<int> top,
	     std::vector<int> bottom) {

  int size_x = x.size();
  std::vector<int> counts(3);
  std::vector<float> props(3);
  
  for (int i=0; i < size_x; i++) {
    
    if (find(top.begin(), top.end(), x[i]) != top.end()) {
      counts[0] += 1;
    }
    if (find(bottom.begin(), bottom.end(), x[i]) != bottom.end()) {
      counts[2] += 1;
    }
    else {
      counts[1] += 1;
    }    
  }

  for (int i=0; i < 3; i++) {
    props[i] = (float)counts[i]/(float)size_x;
  }
  return (props[0] - props[2]);
}

// [[Rcpp::export]]
std::vector<float> npsboot(int R,
			   const std::vector<int> &x,
			   std::vector<int> top,
			   std::vector<int> bottom) {
  
  std::vector<float> bootsample(R);
  int size_x = x.size();
  std::vector<int> candidate(size_x);
  
  for (int i=0; i<R; i++) {
    candidate = RcppArmadillo::sample(x, 
				      size_x, 
				      TRUE, NumericVector::create());
    bootsample[i] = cppnps(candidate, top, bottom);
  }
  return bootsample;
}
