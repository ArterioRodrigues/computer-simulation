#include "helper.h"
#include "poisson.h"
#include <cmath>
#include <vector>

double ITERATION = 10000;
double BINS = 100;

int main() {
  std::vector<double> binarySearchX;
  std::vector<double> binarySearchY;
  std::vector<double> transformationX;
  std::vector<double> transaformationY;
  std::vector<double> poissonX;
  std::vector<double> poissonY;
  std::vector<double> lambdas = {30, 650, 1800};
  double randomUniformNumber;

  for (auto lambda : lambdas) {
    // Transformation Poisson Function
    // for (int i = 0; i < ITERATION; i++) {
    // randomUniformNumber = randomFloatGenerator(0, 1);
    // transaformationY.push_back(transformationMethodPoisson(lambda, randomUniformNumber));
    // transformationX.push_back(randomUniformNumber);
    //}
    // createHistPlot(transaformationY, BINS, "Random Number", "Occurances", "Poisson - Transformation Method");
    // Binary Search Poisson Function
    for (int i = 0; i < ITERATION; i++) {
      binarySearchY.push_back(binarySearchPoissonLog(lambda, std::nullopt));
    }
    createHistPlot(binarySearchY, BINS, "Random Number", "Occurances", "Poisson - Binary Search Method");

    // Expected Poisson Function
    //    PoissonFunction func(lambda);
    //    double index = 0;
    //    double value = 0;
    //    do {
    //      value = func.run(index);
    //      index += 1;
    //      poissonX.push_back(index);
    //      poissonY.push_back(value);
    //    } while (value != 0);
    //  createBarPlot(poissonX, poissonY, "k", "P(N = k)",
    //                  "Theoretical Poisson Distribution(λ=" + std::to_string(lambda) + ")");

    binarySearchX.clear();
    binarySearchY.clear();
    transformationX.clear();
    transaformationY.clear();
    poissonX.clear();
    poissonY.clear();
  }
  return 0;
}
// createScatterPlot(transformationX, transaformationY, "Random Number", "Possion Transformation","Poisson -
// Transformation Method");
// createScatterPlot(binarySearchX, binarySearchY, "Random Number", "Possion Transformation","Poisson - Binary
//     Search Method");
