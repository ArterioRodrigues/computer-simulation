#include "helper.h"
#include "matplotlibcpp.h"
#include "poisson.h"
#include "timer.h"
#include <algorithm>
#include <cmath>
#include <string>
#include <vector>

double ITERATION = 10000;
double BINS = 100;

int main() {
  std::vector<double> binarySearchX;
  std::vector<double> binarySearchY;
  std::vector<double> transaformationX;
  std::vector<double> transaformationY;
  std::vector<long double> poissonX;
  std::vector<long double> poissonY;
  std::vector<double> lambdas = {30, 650, 800};
  double randomUniformNumber;

  long nRows = 1;
  long nCols = 3;
  long nPlot = 1;

  Timer timer;
  for (auto lambda : lambdas) {
    std::cout << "\n=== Lambda = " << lambda << " ===" << std::endl;

    // Transformation Poisson Function
    timer.start();
    for (int i = 0; i < ITERATION; i++) {
      randomUniformNumber = randomFloatGenerator(0, 1);
      transaformationY.push_back(transformationMethodPoisson(lambda, randomUniformNumber));
    }
    timer.end();
    std::cout << "Transformation Search Method: " << timer.result() << "ms" << std::endl;

    // Binary Search Poisson Function
    timer.start();
    for (int i = 0; i < ITERATION; i++) {
      binarySearchY.push_back(binarySearchPoissonLog(lambda, std::nullopt));
    }
    timer.end();
    std::cout << "Binary Search Method: " << timer.result() << "ms" << std::endl;

    // Expected Poisson Function
    timer.start();
    PoissonFunction func(lambda);
    double index = std::min<double>(0, std::abs(lambda - 100));
    double value = 0;
    do {
      value = func.runLog(index);
      index += 1;
      poissonX.push_back(index);
      poissonY.push_back(exp(value));
    } while (index < lambda + 100);

    timer.end();
    std::cout << "Expected Poisson: " << timer.result() << "ms" << std::endl;

    createHistPlot(binarySearchY, BINS, "Random Number", "Occurances", "Poisson - Binary Search Method");
    createHistPlot(transaformationY, BINS, "Random Number", "Occurances", "Poisson - Transformation Method");
    createBarPlot(poissonX, poissonY);

    binarySearchX.clear();
    binarySearchY.clear();
    transaformationX.clear();
    transaformationY.clear();
    poissonX.clear();
    poissonY.clear();
    nPlot = 1;
  }
  return 0;
}
