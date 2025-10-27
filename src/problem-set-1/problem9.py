import numpy as np
import matplotlib.pyplot as plt

def roll_dice():
    return np.random.randint(1, 7) + np.random.randint(1, 7)

def play_craps():
    bank = 1
    come_out = roll_dice()
    
    if come_out in [7, 11]:  # Win
        return bank, True
    elif come_out in [2, 3, 12]:  # Lose
        return bank, False
    else:  # Point established
        point = come_out
        while True:
            bank += 1
            roll = roll_dice()
            if roll == point:
                return bank, True
            elif roll == 7:
                return bank, False

def simulate(N):
    banks = []
    wins = []
    for _ in range(N):
        bank, win = play_craps()
        banks.append(bank)
        wins.append(win)
    return np.array(banks), np.array(wins)

# Simulate
N_values = [1, 5, 10, 20, 200, 1000]
expected_bank = 3.376

results = []
for N in N_values:
    banks, wins = simulate(N)
    mean_bank = np.mean(banks)
    results.append(mean_bank)
    print(f"N={N}: Mean Bank = ${mean_bank:.2f}")

# Plot
plt.figure(figsize=(10, 6))
plt.plot(N_values, results, 'bo-', label='Sample Mean')
plt.axhline(y=expected_bank, color='r', linestyle='--', 
            label=f'Expected Value = ${expected_bank:.2f}')
plt.xlabel('Number of Simulations (N)')
plt.ylabel('Mean Bank Amount ($)')
plt.title('Convergence of Sample Mean to Expected Value')
plt.legend()
plt.grid(True)
plt.xscale('log')
plt.savefig('craps_simulation.png')
plt.show()

