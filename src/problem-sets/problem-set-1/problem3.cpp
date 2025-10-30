#include "./stl.cpp"
#include <algorithm>
#include <random>

enum Card {
    ONE,
    TWO,
    THREE,
    FOUR,
    FIVE,
    SIX,
    SEVEN,
    EIGHT,
    NINE,
    TEN,
    ELEVEN,
    TWELVE,
    THIRTEEN,
};

int main(int argc, char* argv[]) {
    if(argc == 1) {
        std::cout << "Requires a number of iterations" << std::endl;
        return -1;
    }
    std::vector<Card> cards = {ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, ELEVEN, TWELVE, THIRTEEN};
    std::random_device random_device;
    std::mt19937 g(random_device());
    
    int result = 0;
    int numberOfLoops = std::stoi(argv[1]);

    for(int i = 0; i < numberOfLoops; i++) {
        std::shuffle(cards.begin(), cards.end(), g);
        int total = 0;
        for(int i = 0; i < cards.size(); i++) {
            if(cards[i] == i) {
                total += 1;
            }
        }
        //std::cout << "Total number of matches: " << total << std::endl;
        result += total;
    } 
    
    std::cout << "Expected Results: " << float(result)/float(numberOfLoops); 
    return 0;
}
