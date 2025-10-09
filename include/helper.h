#pragma once
#include "matplotlibcpp.h"
#include <chrono>
#include <iostream>
#include <optional>
#include <random>
#include <vector>
namespace plt = matplotlibcpp;
int randomNumberGenerator(int start, int end);
float randomFloatGenerator(float start, float end);
void createScatterPlot(std::vector<double> x, std::vector<double> y, std::string xlabel = "", std::string ylabel = "",
                       std::string title = "");

void createHistPlot(std::vector<double> y, double bins = 10, std::string xlabel = "", std::string ylabel = "",
                    std::string title = "");
void createBarPlot(std::vector<double> x, std::vector<double> y, std::string xlabel = "", std::string ylabel = "",
                   std::string title = "");
double transformationMethodPoisson(double lambda, std::optional<double> randomValue);
double binarySearchPoisson(double lambda, std::optional<double> randomValue);
double binarySearchPoissonLog(double lambda, std::optional<double> randomValue);
double logSumExp(double logA, double logB);
