#include "helper.h"
#include "matplotlibcpp.h"
#include <random>

int randomNumberGenerator(int start, int end) {

  std::random_device randomDevice;
  std::default_random_engine eng(randomDevice());
  std::uniform_int_distribution<int> dist(start, end);

  return dist(eng);
}

int weightedRandomGenerator(const std::vector<double>& weights) {
  std::random_device randomDevice;
  std::default_random_engine eng(randomDevice());
  std::discrete_distribution<int> dist(weights.begin(), weights.end());

  return dist(eng);
}

double randomExponentialNumberGenerator(double scale) {

  std::random_device randomDevice;
  std::default_random_engine eng(randomDevice());
  std::exponential_distribution<double> dist(1.0/scale);

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
}

void createHistPlot(std::vector<double> y, double bins, std::string xlabel, std::string ylabel, std::string title) {
  plt::hist(y, bins, "blue", 1.0);
  plt::xlabel(xlabel);
  plt::ylabel(ylabel);
  plt::title(title);
  plt::show();
}

void createBarPlot(std::vector<long double> x, std::vector<long double> y, std::string xlabel, std::string ylabel,
                   std::string title) {

  plt::bar(x, y);
  plt::xlabel(xlabel);
  plt::ylabel(ylabel);
  plt::title(title);
  plt::show();
}

void createMultiPlot(std::vector<std::vector<long double>> vectorX, std::vector<std::vector<long double>> vectorY,
                     std::vector<std::string> xlabel, std::vector<std::string> ylabel, std::vector<std::string> title) {

  int size = vectorX.size();
  for (int i = 0; i < size; i++) {
    plt::subplot(1, 3, i + 1);
    plt::bar(vectorX[i], vectorY[i]);
    plt::xlabel(xlabel[i]);
    plt::ylabel(ylabel[i]);
    plt::title(title[i]);
  }

  plt::tight_layout();
}
double logSumExp(double logA, double logB) {
  if (logA > logB) {
    return logA + log(1.0 + exp(logB - logA));
  } else {
    return logB + log(1.0 + exp(logA - logB));
  }
}

EventResult findNextEvent(const Events &events) {
  EventResult result;
  result.time = events.arrival;
  result.type = arrival;

  if (events.client1 < result.time) {
    result.time = events.client1;
    result.type = EventType::client1;
  }
  if (events.client2 < result.time) {
    result.time = events.client2;
    result.type = EventType::client2;
  }
  if (events.client3 < result.time) {
    result.time = events.client3;
    result.type = EventType::client3;
  }

  return result;
}
