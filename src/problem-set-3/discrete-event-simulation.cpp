#include "helper.h"

std::vector<double> discreteEventSimulation(double timeInterval, double numberOfReplication, double initalOccupancy, double lambda,
                                            double client1Rate, double client2Rate, double client3Rate, float client1Fee,
                                            float client2Fee, float client3Fee, float client1PenaltyRate,
                                            float client2PenaltyRate) {
  std::vector<double> results = {};
  results.reserve(numberOfReplication);

  for (int i = 0; i < numberOfReplication; i++) {

    double time = 0.0;
    int occupancy = initalOccupancy;

    int client3Rides = 0;
    int client1Penalties = 0;
    int client2Penalties = 0;

    double arrivalTime = randomExponentialNumberGenerator(1.0 / lambda);
    double client1ArrivalTime = randomExponentialNumberGenerator(1.0 / client1Rate);
    double client2ArrivalTime = randomExponentialNumberGenerator(1.0 / client2Rate);
    double client3ArrivalTime = randomExponentialNumberGenerator(1.0 / client3Rate);

    Events events;

    while (time < timeInterval) {
      events.arrival = arrivalTime;
      events.client1 = client1ArrivalTime;
      events.client2 = client2ArrivalTime;
      events.client3 = client3ArrivalTime;

      EventResult nextEvent = findNextEvent(events);

      if (nextEvent.time > timeInterval) {
        break;
      }

      time = nextEvent.time;

      if (nextEvent.type == EventType::arrival) {
        occupancy++;
        arrivalTime = time + randomExponentialNumberGenerator(1.0 / lambda);
      } else if (nextEvent.type == EventType::client1) {
        if (occupancy > 0)
          occupancy--;
        else
          client1Penalties++;

        client1ArrivalTime = time + randomExponentialNumberGenerator(1.0 / client1Rate);
      } else if (nextEvent.type == EventType::client2) {
        if (occupancy > 0)
          occupancy--;
        else
          client2Penalties++;

        client2ArrivalTime = time + randomExponentialNumberGenerator(1.0 / client2Rate);
      }

      else if (nextEvent.type == EventType::client3) {
        if (occupancy > 0) {
          occupancy--;
          client3Rides++;
        }

        client3ArrivalTime = time + randomExponentialNumberGenerator(1.0 / client3Rate);
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
