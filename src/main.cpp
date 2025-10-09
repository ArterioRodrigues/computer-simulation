#include "helper.h"
#include "matplotlibcpp.h"
#include "poisson.h"
#include "timer.h"
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
  std::vector<double> poissonX;
  std::vector<double> poissonY;
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
      transaformationX.push_back(i);
    }
    timer.end();
    std::cout << "Transformation Search Method: " << timer.result() << "ms" << std::endl;

    // Binary Search Poisson Function
    timer.start();
    for (int i = 0; i < ITERATION; i++) {
      binarySearchY.push_back(binarySearchPoissonLog(lambda, std::nullopt));
      binarySearchX.push_back(i);
    }
    timer.end();
    std::cout << "Binary Search Method: " << timer.result() << "ms" << std::endl;

    // Expected Poisson Function
    timer.start();
    PoissonFunction func(lambda);
    double index = 0;
    double value = 0;
    do {
      value = func.run(index);
      index += 1;
      poissonX.push_back(index);
      poissonY.push_back(value);
    } while (value != 0);

    timer.end();
    std::cout << "Expected Poisson: " << timer.result() << "ms" << std::endl;

    // Plotting Graphs
    plt::figure_size(1800, 800);
    plt::subplot(nRows, nCols, nPlot++);
    createHistPlot(binarySearchY, BINS, "Random Number", "Occurances", "Poisson - Binary Search Method");

    plt::subplot(nRows, nCols, nPlot++);
    createHistPlot(transaformationY, BINS, "Random Number", "Occurances", "Poisson - Transformation Method");

    plt::subplot(nRows, nCols, nPlot++);
    plt::bar(poissonX, poissonY);
    plt::xlabel("k");
    plt::ylabel("P(N=K)");
    plt::title("Theoretical Poisson Distribution");
    plt::show();

    binarySearchY.clear();
    transaformationY.clear();
    poissonX.clear();
    poissonY.clear();
    nPlot = 1;
  }
  return 0;
}
