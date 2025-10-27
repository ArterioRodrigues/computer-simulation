#pragma once
#include "matplotlibcpp.h"
#include <chrono>
#include <iostream>
#include <optional>
#include <random>
#include <vector>
#include <numeric>
namespace plt = matplotlibcpp;

//RANDOM NUMBER GEN
int randomNumberGenerator(int start, int end);
int weightedRandomGenerator(const std::vector<double>& weights);
double randomExponentialNumberGenerator(double scale = 1.0);
float randomFloatGenerator(float start, float end);

//MATPLOTLIB PLOTS
void createScatterPlot(std::vector<double> x, std::vector<double> y, std::string xlabel = "", std::string ylabel = "",
                       std::string title = "");
void createHistPlot(std::vector<double> y, double bins = 10, std::string xlabel = "", std::string ylabel = "",
                    std::string title = "");
void createBarPlot(std::vector<long double> x, std::vector<long double> y, std::string xlabel = "",
                   std::string ylabel = "", std::string title = "");
void createMultiPlot(std::vector<std::vector<double>> vectorX, std::vector<std::vector<double>> y,
                     std::vector<std::string> xlabel, std::vector<std::string> ylabel, std::vector<std::string> title);


//RANDOM VARIABLE GEN
double transformationMethodPoisson(double lambda, std::optional<double> randomValue);
double transformationMethodPoissonLog(double lambda, std::optional<double> randomValue);
double binarySearchPoisson(double lambda, std::optional<double> randomValue);
double binarySearchPoissonLog(double lambda, std::optional<double> randomValue);
double logSumExp(double logA, double logB);


//SIMULATIONS
std::vector<double> discreteEventSimulation(double timeInterval, double numberOfReplication, double initalOccupancy, double lambda = 6,
                               double client1Rate = 3, double client2Rate = 1, double client3Rate = 4, float client1Fee = 0.5,
                               float client2Fee = 0.1, float client3Fee = 1.25, float client1PenaltyRate = 1.0,
                               float client2PenaltyRate = 0.25);

std::vector<double> retrospectiveSimulation(double timeInterval, double numberOfReplication, double initalOccupancy, double lambda = 6,
                               double client1Rate = 3, double client2Rate = 1, double client3Rate = 4, float client1Fee = 0.5,
                               float client2Fee = 0.1, float client3Fee = 1.25, float client1PenaltyRate = 1.0,
                               float client2PenaltyRate = 0.25);


enum EventType{
  arrival,
  client1,
  client2,
  client3,
};

struct Events {
  double arrival;
  double client1;
  double client2;
  double client3;
};
struct EventResult {
  double time;
  EventType type;
};

EventResult findNextEvent(const Events &events);
