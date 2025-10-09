Currently `run.sh` is set up to Generates 10,000 Poisson random variables using the Binary Search algorithm and displays histograms for λ = 30, 650, and 1800.

### Prerequisites

Python 3 with matplotlib
CMake
C++ compiler (with C++11 support)

### Installation

Install Dependencies
Ubuntu/Debian:
```bs
sudo apt-get install python3 python3-dev python3-pip cmake
pip3 install matplotlib numpy
```
macOS:
```bs
brew install python3 cmake
pip3 install matplotlib numpy
```

Build and Run
Can run the run.sh file or build with cmake.
```bash
mkdir build
cd build
cmake ..
make
./main
```
