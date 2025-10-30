#include "helper.h"
#include "poisson.h"

double binarySearchPoisson(double lambda, std::optional<double> randomValue) {
  double randomUniformNumber;

  if (randomValue.has_value()) {
    randomUniformNumber = randomValue.value();
  }

  else {
    randomUniformNumber = randomFloatGenerator(0, 1);
  }

  double n = int(lambda);
  PoissonFunction func(lambda);

  double cumulativeProbability = func.cumulativeProbability(n);
  double poissonProbability = func.run(n);

  if (randomUniformNumber <= cumulativeProbability) {
    while (randomUniformNumber <= cumulativeProbability) {
      cumulativeProbability -= poissonProbability;
      poissonProbability = (n * poissonProbability) / lambda;
      n -= 1;
    }
    return n + 1;
  }

  else {
    while (randomUniformNumber > cumulativeProbability) {
      poissonProbability = (lambda * poissonProbability) / (n + 1);
      cumulativeProbability += poissonProbability;
      n += 1;
    }

    return n;
  }

  return -1;
};
