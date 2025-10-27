#include "helper.h"
int main() {
  int numberOfReplication = 1000;
  int time = 120;
  int initalOccupancy = 10;

  std::vector<double> results = discreteEventSimulation(time,                // 120
                                                        numberOfReplication, // 1000
                                                        initalOccupancy,     // 10
                                                        6,                   // lambda (bike arrival rate)
                                                        3,                   // client1Rate (mu1)
                                                        1,                   // client2Rate (mu2)
                                                        4,                   // client3Rate (mu3)
                                                        0.5,                 // client1Fee (K1)
                                                        0.1,                 // client2Fee (K2)
                                                        1.25,                // client3Fee (K3)
                                                        1.0,                 // client1PenaltyRate (c1)
                                                        0.25                 // client2PenaltyRate (c2)
  );

  double sum = std::accumulate(results.begin(), results.end(), 0.0);
  double mean = sum / numberOfReplication;

  std::cout << "Estimated Net Profit: $" << mean << std::endl;

  createHistPlot(results);

  return 0;
}
