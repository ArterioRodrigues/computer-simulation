#include "helper.h"

double transformationMethodPoissonLog(double lambda, std::optional<double> randomValue) {

  double randomUniformNumber;

  if (randomValue.has_value()) {
    randomUniformNumber = randomValue.value();
  }
  else {
    randomUniformNumber = randomFloatGenerator(0, 1);
  }

  double threshold = -lambda;
  double logP = log(randomUniformNumber);  
  double n = 0;

  while (logP > threshold) {
    randomUniformNumber = randomFloatGenerator(0, 1);
    logP += log(randomUniformNumber);  
    n += 1;
  }

  return n;
}
