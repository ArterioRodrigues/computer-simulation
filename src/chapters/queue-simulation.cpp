#include "helper.h"

struct Events {
  double customerArrival;  
  double customerServingTime;  
};

struct Customer {
  double timeOfEnter;
  double servingTime;
};

double queueSimulation(double lambda, double serverDispatchRate, double iterations) {
  Events events = {};

  double time = 0;
  std::queue<Customer> queue; 
  Customer customer;

  for (int i = 0; i < iterations; i++) {

    events.customerArrival = transformationMethodPoissonLog(lambda);
    events.customerServingTime = transformationMethodPoissonLog(serverDispatchRate);

    if(events.customerArrival + i > time) {
      
      queue.push(events.customerServingTime);
    } else {
      if(queue.size() > 0) {
        
      } 
      time += events.customerServingTime; 
    }
    
  }
  return 0.0;
}
