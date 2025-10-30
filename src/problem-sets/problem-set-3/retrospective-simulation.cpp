#include "helper.h"

enum EventType {
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
int generateM(double lambda, double timeInterval) {
  double randomNumber = randomFloatGenerator(0, 1);
  return transformationMethodPoissonLog(lambda * timeInterval, randomNumber);
}

std::vector<double> retrospectiveSimulation(double timeInterval, double numberOfReplication, double initalOccupancy,
                                            double lambda, double client1Rate, double client2Rate, double client3Rate,
                                            float client1Fee, float client2Fee, float client3Fee,
                                            float client1PenaltyRate, float client2PenaltyRate) {

  double lambdaTotal = lambda + client1Rate + client2Rate + client3Rate;

  std::vector<double> eventWeights = {lambda, client1Rate, client2Rate, client3Rate};
  std::vector<double> results = {};
  results.reserve(numberOfReplication);

  for (int i = 0; i < numberOfReplication; i++) {
    int M = generateM(lambdaTotal, timeInterval);

    int occupancy = initalOccupancy;
    int client3Rides = 0;
    int client1Penalties = 0;
    int client2Penalties = 0;

    for (double j = 0; j < M; j++) {
      int randomEvent = weightedRandomGenerator(eventWeights);

      if (randomEvent == EventType::arrival) {
        occupancy += 1;
      } else if (randomEvent == EventType::client1) {
        if (occupancy > 0)
          occupancy -= 1;
        else
          client1Penalties += 1;
      }

      else if (randomEvent == EventType::client2) {
        if (occupancy > 0)
          occupancy -= 1;
        else
          client2Penalties += 1;
      }

      else if (randomEvent == EventType::client3) {
        if (occupancy > 0) {
          occupancy -= 1;
          client3Rides += 1;
        }
      }
    }
    double membershipRevenue = (client1Fee * client1Rate + client2Fee * client2Rate) * timeInterval;
    double rideRevenue = client3Rides * client3Fee;
    double penalties = client1Penalties * client1PenaltyRate + client2Penalties * client2PenaltyRate;
    double netProfit = membershipRevenue + rideRevenue - penalties;

    results.push_back(netProfit);
  }

  return results;
}
