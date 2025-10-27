#include <iostream>
#include <ostream>
#include <string>
#include <random>
#include <vector>
#include <map>

enum Choices {
    RIGHT,
    LEFT_RIGHT,
    LEFT_LEFT,
};

int theseusWalk(bool verbose) {
    int time = 0;
    int chosenIndex = -1;
    std::vector<double> weights = {0.5, 0.5 * 0.33, 0.5 * 0.66};

    std::random_device randomDevice;
    std::mt19937 gen(randomDevice());
    std::discrete_distribution<> distribution(weights.begin(), weights.end());
    

    while(chosenIndex != 1) {
        chosenIndex = distribution(gen);
        switch (chosenIndex) {
            case RIGHT:
                time += 3;
                    if(verbose) std::cout << "Theseus went right" << std::endl;
                break;
            case LEFT_RIGHT:
                time += 2;
                if(verbose) std::cout << "Theseus went left right" << std::endl;
                break;
            case LEFT_LEFT:
                time += 5;
                if(verbose) std::cout << "Theseus went left and Left" << std::endl;
                break;
        }
    }

    return time;
}

int main(int argc, char* argv[]) {
    if(argc == 1) {
        std::cout << "requires one input -> the number of simulations to run" << std::endl;
        return -1;
    }
    std::cout << "number of simulations: " << argv[1] << std::endl;
    int numberOfSimulations = std::stoi(argv[1]);
    int time = 0;
    bool verbose = argv[2] ? true : false; 
    std::map<int, int> walks; 
    
    for(int i = 0; i < numberOfSimulations; i++) {
        int walk = theseusWalk(verbose); 
        time += walk; 
        walks[walk] += 1;
    }
    
    for(const auto& pair : walks) {
        std::cout << "Theseus took " << pair.first << " minutes " << pair.second << " times" << std::endl; 
    }

    std::cout << "Theseus walked for an average: " << time/numberOfSimulations << std::endl;
    return 0;
}
