#pragma once
#include "helper.h"
#include <cmath>
#include <iostream>

class PoissonFunction {
public:
  PoissonFunction(double lambda) { _lambda = lambda; }

  double run(double k) { return this->_poissonFunction(_lambda, k); }
  double runLog(double k) { return this->_poissonFunctionLog(_lambda, k); }
  double cumulativeProbability(double n) {
    double result = 0;
    for (int i = 0; i <= n; i++) {
      result += this->run(i);
    }

    return result;
  }
  double cumulativeProbabilityLog(double n) {
    double result = this->runLog(0);
    for (int i = 1; i <= n; i++) {
      result = logSumExp(result, this->runLog(i));
    }

    return result;
  }

private:
  double _lambda;
  double _poissonFunction(double l, double k) { return (exp(-l) * pow(l, k)) / _factorial(k); }
  double _poissonFunctionLog(double l, double k) { return -l + k * log(l) - _logFactorial(k); }
  double _factorial(int k) {
    if (k < 0) {
      return -1;
    }

    if (k == 0 || k == 1) {
      return 1;
    } else {
      return k * _factorial(k - 1);
    }
  }
  double _logFactorial(int k) {
    if (k == 0) return 0;
    double result = 0;

    for (int i = 1; i <= k; i++) {
      result += log(i);
    }
    return result;
  }
};
