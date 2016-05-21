#include <vector>
#include <RcppArmadilloExtensions/sample.h>

using namespace Rcpp;
using namespace std;

// [[Rcpp::depends(RcppArmadillo)]]

float cppnps(const vector<int> &x, vector<int> top, vector<int> bottom) {

  int size_x = x.size();
  vector<int> counts(3);
  vector<float> props(3);
  
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
vector<float> npsboot(int R, const vector<int> &x, vector<int> top, vector<int> bottom) {
  
  vector<float> bootsample(R);
  int size_x = x.size();
  vector<int> candidate(size_x);
  
  for (int i=0; i<R; i++) {
    candidate = RcppArmadillo::sample(x, 
				      size_x, 
				      TRUE, NumericVector::create());
    bootsample[i] = cppnps(candidate, top, bottom);
  }
  return bootsample;
}
