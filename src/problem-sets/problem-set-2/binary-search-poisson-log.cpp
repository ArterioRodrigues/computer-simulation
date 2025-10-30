#include "helper.h"
#include "poisson.h"

double binarySearchPoissonLog(double lambda, std::optional<double> randomValue) {
  double logRandomUniform;

  if (randomValue.has_value()) {
    logRandomUniform = log(randomValue.value());
  }

  else {
    logRandomUniform = log(randomFloatGenerator(0, 1));
  }

  double n = int(lambda);
  PoissonFunction func(lambda);

  double logCumulativeProbability = func.cumulativeProbabilityLog(n);
  double logPoissonProbability = func.runLog(n);

  if (logRandomUniform <= logCumulativeProbability) {
    while (logRandomUniform <= logCumulativeProbability && n > 0) {
      // logCumulativeProbability = func.cumulativeProbabilityLog(n - 1);
      n -= 1;
      logCumulativeProbability = func.cumulativeProbabilityLog(n);
    }
    return n + 1;
  }

  else {
    while (logRandomUniform > logCumulativeProbability) {
      n += 1;
      // logCumulativeProbability = func.cumulativeProbabilityLog(n);
      logPoissonProbability = logPoissonProbability + log(lambda) - log(n);
      logCumulativeProbability = logSumExp(logCumulativeProbability, logPoissonProbability);
    }

    return n;
  }

  return -1;
};
