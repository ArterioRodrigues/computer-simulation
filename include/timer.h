#pragma once
#include <chrono>
#include <iostream>

class Timer {
private:
  std::chrono::time_point<std::chrono::high_resolution_clock> _start;
  std::chrono::time_point<std::chrono::high_resolution_clock> _end;

public:
  void start() { _start = std::chrono::high_resolution_clock::now(); }
  void end() { _end = std::chrono::high_resolution_clock::now(); }
  double result() {
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(_end - _start);
    return duration.count();
  }
};
