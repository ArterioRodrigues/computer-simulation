#include "helper.h"

double transformationMethodPoisson(double lambda, std::optional<double> randomValue) {

  double randomUniformNumber;

  if (randomValue.has_value()) {
    randomUniformNumber = randomValue.value();
  }

  else {
    randomUniformNumber = randomFloatGenerator(0, 1);
  }

  double constantThreshold = exp(-lambda);
  double p = randomUniformNumber;
  double n = 1;

  while (p > constantThreshold) {
    randomUniformNumber = randomFloatGenerator(0, 1);
    p *= randomUniformNumber;
    n += 1;
  }

  return n - 1;
}
