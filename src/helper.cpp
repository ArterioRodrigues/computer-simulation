#include "helper.h"

int randomNumberGenerator(int start, int end) {

  std::random_device randomDevice;
  std::default_random_engine eng(randomDevice());
  std::uniform_int_distribution<int> dist(start, end);

  return dist(eng);
}

float randomFloatGenerator(float start, float end) {
  unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
  static std::default_random_engine generator(seed);
  std::uniform_real_distribution<float> distribution(start, end);

  return distribution(generator);
}

void createScatterPlot(std::vector<double> x, std::vector<double> y, std::string xlabel, std::string ylabel,
                       std::string title) {

  plt::scatter(x, y);
  plt::xlabel(xlabel);
  plt::ylabel(ylabel);
  plt::title(title);
  plt::show();
}

void createHistPlot(std::vector<double> y, double bins, std::string xlabel, std::string ylabel, std::string title) {
  plt::hist(y, bins);
  plt::xlabel(xlabel);
  plt::ylabel(ylabel);
  plt::title(title);
  plt::show();
}

void createBarPlot(std::vector<double> x, std::vector<double> y, std::string xlabel, std::string ylabel,
                   std::string title) {

  plt::bar(x, y);
  plt::xlabel(xlabel);
  plt::ylabel(ylabel);
  plt::title(title);
  plt::show();
}

double logSumExp(double logA, double logB) {
  if (logA > logB) {
    return logA + log(1.0 + exp(logB - logA));
  } else {
    return logB + log(1.0 + exp(logA - logB));
  }
}
