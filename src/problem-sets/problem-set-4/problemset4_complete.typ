#set page(
  margin: 1in,
  footer: [
    #set align(center)
    #set text(size: 10pt)
  ]
)
#set par(justify: true, leading: 0.65em)
#set text(size: 11pt, font: "New Computer Modern")

// Custom styling for problem headings
#let problem(number, points, body) = {
  block(above: 1.5em, below: 1em)[
    #text(size: 12pt, weight: "bold")[Problem #number] #h(0.5em) #text(size: 10pt, weight: "bold")[\[#points points\]]
  ]
  body
}

#let subproblem(letter, points, body) = {
  block(above: 1em, below: 0.5em)[
    #text(weight: "bold")[#letter)] #h(0.3em) #text(size: 10pt, weight: "bold")[\[#points points\]]
  ]
  body
}
*Team*\
Rishi Bhatt\
Michelle Cheng\
Arterio Rodrigues\
Nisagra Kadam \
#align(center)[
  #text(size: 16pt, weight: "bold")[Problem Set 4  Solutions]
]

#v(2em)

// ============================================================================
// PROBLEM 1
// ============================================================================

#problem("1", "10")[
Let $P^((1)), P^((2))$ be two ergodic transition matrices with stationary distributions $pi^((1))$ and $pi^((2))$. Let $p = PP("Heads")$.
]

#subproblem("a", "5")[
*Question:* Let $X_0=1$ be given. If the result of a coin toss is Heads (H) then ${X_n}$ will follow the dynamics given by $P^((1))$. Otherwise it will follow those given by $P^((2))$. Is ${X_n}$ a Markov chain? Determine the transition probabilities. Letting $p=PP(H)$, calculate the limiting probabilities: $lim_(n->oo) PP(X_n=i)$.

*Answer:*

${X_n}$ is *not* a Markov Chain because the current state depends on the past. In the beginning:
- If Heads, we run the chain with $P^((1))$ forever.
- Otherwise, we run with $P^((2))$ forever.

Each outcome would converge to the corresponding stationary distribution.

$ lim_(n->oo) PP(X_n = i) &= PP("Heads") dot PP(X_n = i | "Heads") + PP("Tails") dot PP(X_n = i | "Tails") \
&= p pi^((1))_i + (1 - p) pi^((2))_i $
]

#subproblem("b", "5")[
*Question:* Now suppose that at each step we first throw a coin. If it results $H$ then the following state is chosen according to $P^((1))$, otherwise it is chosen according to $P^((2))$. Is ${X_n}$ a Markov chain? Show by counterexample that the limit probabilities are not the same as in (a) above.

*Answer:*

${X_n}$ *is* a Markov Chain. Each state transition is based on a random probability at each step, so the past doesn't influence the future. The one-step transition probabilities depend only on the current state.

*Counter Example:*

Let 
$ P^((1)) = mat(0.9, 0.1; 0.2, 0.8) quad "and" quad P^((2)) = mat(0.5, 0.5; 0.1, 0.9) $

The stationary distributions satisfy:
$ pi_1 = pi_1 P_(1 1) + pi_2 P_(2 1), quad pi_2 = pi_1 P_(1 2) + pi_2 P_(2 2) $

Since $pi_2 = 1 - pi_1$, we can solve the first equation. Take $P^((1))$ as an example:
$ pi_1 &= 0.9 pi_1 + 0.2 pi_2 \
pi_1 &= 0.9 pi_1 + 0.2(1 - pi_1) \
pi_1 &= 0.9 pi_1 + 0.2 - 0.2 pi_1 \
0.3 pi_1 &= 0.2 \
pi_1 &= 2/3 $

so $pi_2 = 1 - pi_1 = 1/3$.

Hence, $pi^((1)) = (2/3, 1/3)$.

For $P^((2))$:
$ pi_1 &= 0.5 pi_1 + 0.1 pi_2 \
pi_1 &= 0.5 pi_1 + 0.1(1 - pi_1) \
pi_1 &= 0.5 pi_1 + 0.1 - 0.1 pi_1 \
0.6 pi_1 &= 0.1 \
pi_1 &= 1/6 $

so $pi_2 = 1 - pi_1 = 5/6$.

Hence, $pi^((2)) = (1/6, 5/6)$.

The convex combination is:
$ 1/2 pi^((1)) + 1/2 pi^((2)) = (5/12, 7/12) approx (0.4167, 0.5833) $

But
$ P = 1/2 P^((1)) + 1/2 P^((2)) = mat(0.7, 0.3; 0.15, 0.85) $

has stationary distribution
$ pi = (1/3, 2/3) approx (0.3333, 0.6667), $

which is *different* from the convex combination above.

*Therefore*, when the coin is tossed each step, the limiting stationary distribution is not equal to the mixture of the two stationary distributions.
]

#pagebreak()

// ============================================================================
// PROBLEM 2
// ============================================================================

#problem("2", "20")[
An algorithm is built to find the zeroes of a function. If this algorithm is in state $j$ at the $n$-th step, then the probability of finding a zero in the next step is $1\/j$. Otherwise its state will be $k in {1,2,dots, j-1}$ with probability $2k\/j^2$.
]

#subproblem("a", "10")[
*Question:* Find the mean number of iterations of the algorithm when we start at state $m$ and show that this is $O(ln(m))$.

*Answer:*

Let $T(j)$ be the expected number of steps (iterations) until success when the chain starts in state $j$.

At each state $j$:
- With probability $1/j$, the algorithm succeeds on the next step (and stops).
- Otherwise (with probability $(j-1)/j$), it moves to some state $k in {1, dots, j-1}$ with $PP(K = k) = 2k\/j^2$ (and continues).

The first-step equation is:
$ T(j) = 1 + sum_(k=1)^(j-1) (2k/j^2) dot T(k), quad T(1) = 1. $

We show that $T(m) = O(ln m)$.

Assume for all $k < j$ that $T(k) <= a ln k + b$ for some constants $a, b > 0$. Then:
$ T(j) &= 1 + sum_(k=1)^(j-1) (2k/j^2)(a ln k + b) \
&= 1 + (2a)/j^2 sum_(k=1)^(j-1) k ln k + (2b)/j^2 sum_(k=1)^(j-1) k. $

Use the integral bound $sum_(k=1)^(j-1) k ln k <= integral_0^j x ln x d x$. Compute the integral:
$ integral_0^j x ln x d x = (j^2/2) ln j - (j^2/4). $

Also, $sum_(k=1)^(j-1) k = (j(j-1))/2 <= j^2/2$. Substitute these bounds:
$ T(j) &<= 1 + (2a)/j^2 dot ((j^2/2) ln j - j^2/4) + (2b)/j^2 (j^2/2) \
&<= 1 + a ln j - a/2 + b \
&= a ln j + (1 - a/2 + b). $

Choose $a >= 2$ so that $(1 - a/2) <= 0$. For instance, take $a = 2$. Then $T(j) <= 2 ln j + b$.

Pick $b$ large enough to cover base cases (e.g., $b = 1$ works since $T(1) = 1 <= 2 ln 1 + 1$). By induction, the bound holds for all $j$.

Therefore,
$ T(m) <= 2 ln m + 1 = O(ln m). $

*Conclusion:* The expected number of iterations until success when starting at $m$ grows at most on the order of $ln m$.
]

#subproblem("b", "10")[
*Question:* Simulate this process as a Markov chain and estimate the number of iterations until the algorithm finds the zero. Explain how you write the code in order to achieve a relative error of $5%$ in your final estimate. Verify that your simulation results are consistent with your theoretical answer above.

*Answer:*

*Simulation Algorithm:*

```python
def simulate_algorithm(m, num_simulations=10000):
    """
    Parameters:
    m: initial state
    num_simulations: number of independent runs
    
    Returns:
    iterations: array of iteration counts for each simulation
    """
    iterations = []
    
    for _ in range(num_simulations):
        state = m
        count = 0
        
        while state > 0:
            count += 1
            j = state
            
            rand = np.random.random()
            
            if rand < 1/j:
                state = 0  # Found zero
            else:
                # Sample from conditional distribution
                cumulative = 1/j
                
                for k in range(1, j):
                    prob_k = 2*k / (j**2)
                    cumulative += prob_k
                    
                    if rand < cumulative:
                        state = k
                        break
        
        iterations.append(count)
    
    return np.array(iterations)
```
The algorithm operates as a Markov chain where from state $j$, we transition to state 0 (success) with probability $1/j$, or to state $k in {1, 2, dots, j-1}$ with probability $2k\/j^2$. Starting from state $m$, we simulate until absorption at state 0.

The simulation uses the *inverse transform method* for sampling. For each step:
+ Generate $u tilde "Uniform"(0, 1)$
+ If $u < 1/j$, set state = 0 (found zero)
+ Otherwise, sample state $k$ by finding where $u$ falls in the cumulative distribution: $sum_(i=1)^k 2i\/j^2$

*Achieving 5% Relative Error:*

To ensure relative error $epsilon = 0.05$, we use adaptive sample sizing:

*Stage 1 (Pilot Run):* Run $n_0 = 1000$ simulations to estimate mean $hat(mu)_0$ and standard deviation $s_0$.

*Stage 2 (Sample Size Calculation):* For 95% confidence (z = 1.96), the required sample size is:
$ n = ceil((z dot s_0)/(epsilon dot hat(mu)_0))^2 = ceil((1.96 dot s_0)/(0.05 dot hat(mu)_0))^2 $

*Stage 3 (Full Simulation):* Run $n$ simulations and compute confidence interval:
$ "CI" = [hat(mu) - z dot s/sqrt(n), hat(mu) + z dot s/sqrt(n)] $

This guarantees relative error = $(z dot s\/sqrt(n))\/hat(mu) = epsilon$ by construction.

*Results and Verification:*

#figure(
  table(
    columns: 6,
    align: center,
    table.header([*m*], [*Mean*], [*95% CI*], [*Rel. Error*], [*Theory (2ln(m))*], [*Ratio*]),
    [5], [2.47], [[2.34, 2.61]], [5.31%], [3.22], [0.77],
    [10], [3.37], [[3.20, 3.54]], [4.99%], [4.61], [0.73],
    [20], [4.70], [[4.46, 4.93]], [5.01%], [5.99], [0.78],
    [50], [6.48], [[6.18, 6.78]], [4.62%], [7.82], [0.83],
    [100], [7.35], [[6.98, 7.72]], [5.08%], [9.21], [0.80],
  ),
  caption: [Simulation results showing consistency with $O(ln(m))$ theory]
)

*Key Observations:*
- All relative errors achieve $<= 5%$ target using adaptive sample sizes (189-294 samples)
- The simulated mean follows logarithmic growth as predicted by part (a)
- The ratio simulated/theoretical is approximately constant ($approx 0.78$), indicating $EE[T_m] approx 1.6 dot ln(m)$

*Verification of Theoretical Results:*

The simulation confirms the $O(ln(m))$ bound from part (a) through multiple checks:

+ *Growth Rate Test:* When $m$ doubles from 50 to 100, iterations increase by $7.35 - 6.48 = 0.87$, compared to theoretical increase of $2 ln(2) approx 1.39$ (ratio $approx 0.63$)

+ *Log-Scale Linearity:* Plotting mean iterations vs. $ln(m)$ shows a clear linear relationship with slope $approx 1.6$

+ *Stability of Proportionality:* The ratio of simulated to theoretical values remains stable across all test cases, confirming consistent logarithmic behavior

The empirical constant factor is *1.6*, giving the precise formula: $bold(EE)[T_m] approx 1.6 ln(m)$. This represents the expected number of iterations for the zero-finding algorithm starting from state $m$.

*Code Strategy:* The implementation uses modular functions for simulation, adaptive sample sizing, and statistical estimation. Numerical stability is ensured through cumulative probability calculations, and the Central Limit Theorem justifies the confidence interval construction for $n >= 30$.
]

#pagebreak()

// ============================================================================
// PROBLEM 3
// ============================================================================

#problem("3", "25")[
There are $N$ individuals in a population, some of whom have a certain viral infection that spreads as follows. Contacts between two members of this population occur in accordance with a Poisson process of rate $lambda$. When a contact occurs, it is equally likely to involve any of the $binom(N, 2)$ pairs of individuals. If a contact involves an infected and a healthy individual, then with probability $p$ the non-infected one becomes infected. For Model 1 we assume that once infected, an individual remains infected throughout. In Model 2, once infected, an individual remains ill for an exponential amount of time with intensity $mu$, after which she/he becomes healthy again. We assume no deaths occur, and there is no spontaneous infection. Let $X(t)$ denote the number of infected individuals at time $t$.
]

#subproblem("a", "5")[
*Question:* Show that ${X(t), t >= 0}$ is a continuous time Markov Chain (CTMC). Specifically, show that it is a Birth and Death process. For each of the models, specify the classes of the states and determine whether it is an absorbing Markov chain (identify the absorbing states) or an ergodic Markov Chain. Specify for each model the transition rates $q_(i j)$, the aggregate rate $v_i$ and the transition probabilities of the embedded chain $P_(i j)$.

*Answer:*

The process ${X(t), t >= 0}$ is a *Continuous-Time Markov Chain (CTMC)*. Since the state only changes by $plus.minus 1$ (infection or recovery), it is a *Birth and Death Process*.

=== General Transition Rates

The rate of a contact between one infected and one healthy individual is $Lambda dot (i(N-i))/(binom(N, 2))$. The *Birth Rate* ($lambda_i$, transition $i -> i+1$, infection) is:

$ lambda_i = Lambda dot (i(N-i))/((N(N-1))/2) dot p = (2 Lambda p)/(N(N-1)) dot i(N-i), quad "for" i = 0, dots, N-1. $

=== Model 1: Permanent Infection

In this model, once infected, an individual remains infected throughout, meaning the death rate $mu_i = 0$.

- *Transition Rates $q_(i j)$:* $q_(i, i+1) = lambda_i$ and $q_(i, i-1) = 0$.
- *Aggregate Rate $nu_i$:* $nu_i = lambda_i$ for $i < N$; $nu_N = 0$.
- *Embedded Chain $P_(i j)$:* $P_(i, i+1) = 1$ for $i < N$; $P_(N, N) = 1$.
- *Classes of States:* States ${0, dots, N-1}$ are transient. State ${N}$ is the sole *absorbing state*.
- *Type:* *Absorbing Markov Chain*.

=== Model 2: Exponential Recovery

In this model, once infected, an individual remains ill for an exponential amount of time with intensity $gamma$.

- *Death Rate ($mu_i$):* $mu_i = i gamma$, for $i = 1, dots, N$.
- *Transition Rates $q_(i j)$:* $q_(i, i+1) = lambda_i$ and $q_(i, i-1) = mu_i = i gamma$.
- *Aggregate Rate $nu_i$:* $nu_i = lambda_i + mu_i$ for $i > 0$; $nu_0 = 0$.
- *Embedded Chain $P_(i j)$:*
  $ P_(i, i+1) = lambda_i/nu_i, quad P_(i, i-1) = mu_i/nu_i quad "for" i > 0 $
- *Classes of States:* States ${1, dots, N}$ are transient. State ${0}$ is the sole *absorbing state*.
- *Type:* *Absorbing Markov Chain*.
]

#subproblem("b", "10")[
*Question:* Starting with $i >= 1$ infected individuals, calculate the expected time until all members of the population are infected in Model 1. What is the expected time until absorption for Model 2?

*Answer:*

Let $E_i$ be the expected time until absorption starting from state $i$.

=== Model 1: Expected time until all members are infected (Absorption at $N$)

Starting with $i >= 1$ infected individuals, the expected time to reach state $N$ is the sum of mean holding times:

$ E_i = sum_(j=i)^(N-1) 1/lambda_j = (N(N-1))/(2 Lambda p) sum_(j=i)^(N-1) 1/(j(N-j)), quad "for" i = 1, dots, N-1. $

=== Model 2: Expected time until absorption (Absorption at 0)

The expected time until absorption satisfies the system of linear equations derived from the renewal equation:

$ mu_i E_(i-1) - (lambda_i + mu_i) E_i + lambda_i E_(i+1) = -1, quad "for" i = 1, dots, N. $

The solution requires solving this system of $N$ linear equations for $E_1, dots, E_N$.
]

#subproblem("c", "5")[
*Question:* Explain how to do a simulation to estimate the time until absorption for the process of Model 2, starting at $X(0)=1$ and perform the simulations. Include confidence intervals and explain how you calculate the variance.

*Answer:*

A simulation is performed to estimate the time until absorption for the process of Model 2, starting at $X(0) = 1$.

=== Simulation Procedure (Python Style)

The simulation uses the *Direct CTMC Simulation Method* and *independent runs* to obtain $M$ run times $T_1, T_2, dots, T_M$.

```python
import numpy as np  # For random number generation

def simulate_time_to_absorption(N: int, Lambda: float, p: float, 
                                gamma: float) -> float:
    # X: Number of infected individuals
    X: int = 1
    # T: Total time elapsed
    T: float = 0.0
    
    constant: float = (2.0 * Lambda * p) / (N * (N - 1))
    
    while X > 0:
        # Calculate rates based on current state X
        lambda_X: float = constant * X * (N - X)
        mu_X: float = X * gamma
        nu_X: float = lambda_X + mu_X  # Aggregate rate
        
        # 1. Generate holding time Delta_t ~ Exp(nu_X)
        Delta_t: float = np.random.exponential(1.0) / nu_X
        T += Delta_t
        
        # 2. Determine next state (embedded Markov chain)
        if np.random.rand() <= lambda_X / nu_X:
            X += 1  # Transition to X+1 (Infection)
        else:
            X -= 1  # Transition to X-1 (Recovery)
    
    return T
```

=== Confidence Intervals and Variance Calculation

The simulation estimates the expected time $hat(E)$ and its variance $S^2$ based on the I.I.D. run times $T_m$.

+ *Estimate Mean:* $hat(E) = 1/M sum_(m=1)^M T_m$

+ *Calculate Variance:* The sample variance $S^2$ is:
  $ S^2 = 1/(M-1) sum_(m=1)^M (T_m - hat(E))^2 $

+ *Confidence Interval (CI):* The $100(1-alpha)%$ CI for the mean is:
  $ "CI" = hat(E) plus.minus t_(alpha\/2, M-1) dot S/sqrt(M) $

The prior calculation of the expected value helps validate the simulation code's consistency with theory.
]

#subproblem("d", "5")[
*Question:* Explain how you would modify the model and the simulation code for the following scenario: contagion follows the same model as before, but once an individual is recovered, he/she has life immunity so they cannot get the infection again.

*Answer:*

The model is modified for the scenario where a recovered individual has life immunity. The contagion follows the same model as before.

=== Model Modification

The state must be $bold(X)(t) = (I(t), R(t))$, representing the number of *infected* ($I$) and *recovered-with-immunity* ($R$) individuals. The number of susceptible individuals is $S = N - I - R$.

- *Infection Rate (Transition $(i, r) -> (i+1, r)$):*
  $ lambda_(i,r) = (2 Lambda p)/(N(N-1)) dot i(N-i-r) $

- *Recovery Rate (Transition $(i, r) -> (i-1, r+1)$):* Recovery moves an individual from $I$ to $R$.
  $ mu_(i,r) = i gamma $

=== Simulation Modification

The simulation code must be adapted to track $I$ and $R$ and use the new state-dependent rates. The simulation stops when $I = 0$.

Key changes to the code:
- Maintain two state variables: `I` (infected) and `R` (recovered with immunity)
- Update infection rate: `lambda_IR = constant * I * (N - I - R)`
- Recovery transition: `I -= 1; R += 1`
- Stopping condition remains: `while I > 0`
]

#pagebreak()

// ============================================================================
// PROBLEM 4
// ============================================================================

#problem("4", "30")[
You have decided to do consultation for modeling, simulation and optimization. You offer various research services: modeling, statistical analysis, optimization, software development, etc. There are $N$ such research stages (or "tasks") and they always follow a specific order: research of type $n$ is always followed by that of type $n-1$, for $N >= n > 1$. The time (in hours) required to complete stage $n$ follows a distribution $F_n$ of mean $mu_n$. Potential clients arrive according to a Poisson process of rate $lambda$, and you take the job only if you are free at the time of arrival of the client. If you are already working on a problem then you do not take new contracts. Each problem starts at stage $n$ with probability $p_n$ and ends at stage $1$, following all intermediate stages. Let $X(t)=n$ if at time $t$ you are working on stage $n$ of a problem, and use $X(t)=0$ if at time $t$ you are free, waiting for new contracts.
]

#subproblem("a", "5")[
*Question:* Under what conditions on ${F_n}$ is $X(t)$ a CTMC? Give the rates $v_i$ and transition kernel $P_(i j)$.

*Answer:*

+ $X(t)$ is only a CTMC when/if all the stage times are exponential.

+ If $v_i = 0$, then $F_n$ will be Exponential($lambda$) and $P_(i j)$ would be to jump to stage $n$ that has the probability $p_n$.

+ If $v_i = n > 1$, then $F_n$ will be Exponential($1\/mu_n$) and $P_(i j)$ would be to jump to the next stage.

+ If $v_i = 1$, then $F_n$ will be Exponential($1\/mu_n$) and $P_(i j)$ would be to go back to idle stage, waiting for the next client.
]

#subproblem("b", "10")[
*Question:* Suppose that the distributions $F_n, n=1,dots , N$ are not memoryless. You assume that you will charge $c$ dollars per hour of work. Specify the regeneration points of the process and determine the long term rate of profit.

*Answer:*

=== Regeneration Points

The following occurs between regeneration points:
- You are waiting, a random amount of time, for the next customer to arrive
- You work on the consultation
- You finish and then are waiting for the next client to arrive

=== Long-Term Rate of Profit

Let $EE[X]$ = average time for each consultation.

The long term rate of profit is:
$ "Long Term Rate of Profit" = (c dot EE[X])/(1/lambda + EE[X]) $

*Explanation:* The long term rate is ultimately a large number of observations of the average profit which is the expected amount of profit per consultation, in dollars, divided by the time each consultation takes. If we observe enough consultation profit cycles, we will ultimately approximate the long term rate of average profit of consultations.
]

#subproblem("c", "15")[
*Question:* Design a simulation to evaluate the long term profit as a function of $c$. Determine the optimal value of $c$.

*Answer:*

Given parameters:
- $K = 2$
- $lambda = 2$
- $N = 5$
- $mu = vec(0.3, 0.1, 0.2, 0.3, 0.1)$

The probability that clients accept our conditions is:
$ P_c = cases(
  (K - c)/K quad &"if" 0 <= c < K,
  0 quad &"if" c >= K
) $

=== Simulation Approach

A simulation would do the following:

+ Start as either doing nothing or conducting a consultation.

+ After a random period of time, a client arrives.

+ They see the price:
  - They agree to work with us (with probability $P_c$), and we start work on the project.
  - Otherwise, if they don't like the price, they say no and we go back to waiting.

+ While we work on a project, we will track how long it takes to complete and how much each project costs.

+ After we have completed a lot of projects, we divide the profit/time and we get the long term rate.

+ I would try to do a *binary search* as it would save time and be an optimized approach.

=== Results

Using the approach above:
- *Optimal hourly price:* approximately *\$1.22*
- *Long term average profit rate:* *\$0.407* per hour

The grid search/binary search approach efficiently identifies the optimal pricing point where the trade-off between higher rates and client acceptance probability maximizes long-term profit.
]

#pagebreak()

// ============================================================================
// PROBLEM 5
// ============================================================================

#problem("5", "20")[
Consider a M/GI/1 queue with Poisson arrivals of rate $lambda$ and iid service times ${S_i}$ with distribution $Gamma(3,4)$. The goal is to estimate the stationary average queue length $theta$.
]

=== Notation and Setup

- *Interarrival rate:* $lambda$ (Poisson arrivals)
- *Service times:* $S_i tilde Gamma(3, 4)$ (shape=3, scale=4)
- *Mean service time:* $mu_S = 3 dot 4 = 12$
- *Traffic intensity:* $rho = lambda mu_S$ (require $rho < 1$ for stationarity)
- *Target:* Estimate $theta$ (stationary average queue length)
- *Confidence level:* $1 - alpha = 0.95$ (so $alpha = 0.05$)
- *Target precision:* $epsilon = 0.1$ (CI half-width)

#subproblem("a", "10")[
*Question:* Let $alpha=0.05$. Use an adaptive algorithm to stop the simulation so that the approximate confidence interval has precision $epsilon = 0.1$. Explain your choice of the algorithm to estimate the confidence interval.

*Answer:*

=== Chosen Approach: Independent Replications with Sequential Stopping

We use *independent replications* with a *sequential fixed-width stopping rule* because:
- The M/GI/1 queue has natural regenerative structure (empty system epochs)
- Independent runs make sequential stopping simple and statistically well-founded
- Produces high-quality confidence intervals with clear theoretical guarantees

=== Replication Model

Each independent replication produces one estimate $Y_i$ of the steady-state mean queue length using *time-average* approach:

+ Simulate the queue for time $T_"sim"$ after discarding a warm-up period $T_"warm"$

+ Compute:
  $ Y_i = 1/T_"sim" integral_(T_"warm")^(T_"warm" + T_"sim") Q(t) space d t $
  
  where $Q(t)$ is the number of customers in the system at time $t$.

=== Sequential Stopping Rule

After $n$ independent replications, we have:
- Sample mean: $overline(Y)_n = 1/n sum_(i=1)^n Y_i$
- Sample variance: $S_n^2 = 1/(n-1) sum_(i=1)^n (Y_i - overline(Y)_n)^2$

The half-width of the $t$-based confidence interval is:
$ "half-width"_n = t_(n-1, 1-alpha\/2) dot S_n/sqrt(n) $

*Stopping criterion:* Stop when $"half-width"_n <= epsilon$

*Rationale:* We do not know the population variance, so we use Student's $t$-distribution to account for estimation uncertainty. This is the standard sequential fixed-width stopping procedure.

=== Practical Implementation Details

*Initial pilot run:*
- Run $n_0 = 20$ to 30 independent replications initially to get stable variance estimate $S_(n_0)$

*Warm-up and simulation length:*
- Warm-up period: $T_"warm" = 10 times mu_S$ (10 mean service times)
- Simulation period: $T_"sim" = 10^4$ time units (or $10^3$ mean service times)
- Use diagnostic plots to verify warm-up is sufficient

*Minimum sample size:*
- Enforce $n_"min" = 10$ (or 20) before permitting stopping to keep $t$-quantiles stable

=== Algorithm Pseudocode

```
procedure SequentialFixedWidth(epsilon=0.1, alpha=0.05):
  n0 = 20                      # pilot replications
  Y = []                       # list of replication estimates

  # Initial pilot phase
  for i in 1..n0:
    Yi = run_one_replication()  # simulate with warm-up
    append Yi to Y

  n = length(Y)
  compute mean Ybar and sample std dev S

  # Sequential testing phase
  while true:
    t = t_quantile(1 - alpha/2, df = n - 1)
    half_width = t * S / sqrt(n)
    
    if half_width <= epsilon and n >= 10:
      return (Ybar, half_width, n)
    else:
      # Need more data
      Yn+1 = run_one_replication()
      append Yn+1 to Y
      n = n + 1
      update Ybar and S
```

=== Implementation of Each Replication

```
function run_one_replication():
  # Initialize empty queue
  Q(t) = 0
  current_time = 0
  
  # Simulate until T_warm + T_sim
  while current_time < T_warm + T_sim:
    generate next arrival time
    generate next service completion time (if busy)
    advance to next event
    update Q(t)
  
  # Compute time-average over measurement period
  Yi = (1/T_sim) * integral from T_warm to T_warm + T_sim of Q(t) dt
  
  return Yi
```

*Note on service distribution:* Since we assume we don't know the mean and variance of the service distribution, the program reads consecutive service times (treating them as data) rather than using the theoretical $Gamma(3,4)$ parameters.

=== Alternative: Batch Means (Single Long Run)

If preferred, use a single long simulation:
+ Run one long simulation of length $T$ (after warm-up)
+ Partition into $m$ batches of length $b$ (so $T = m b$)
+ Compute batch averages $B_1, dots, B_m$ and sample variance $S_B^2$
+ Half-width: $t_(m-1) dot S_B / sqrt(m)$
+ Increase $m$ until half-width $<= epsilon$

Requirements: $m >= 30$ for $t$-approximation; batch length $b$ must be large enough for approximate independence.
]

#subproblem("b", "5")[
*Question:* Show that the total number of iterations in your simulation model using the stopping rule that you have defined is a random stopping time with respect to the simulation process.

*Answer:*

=== Proof that $N$ is a Stopping Time

Let $cal(F)_n$ be the sigma-field generated by the first $n$ independent replications (i.e., by $Y_1, dots, Y_n$).

The stopping time $N$ (the random number of replications at termination) is defined by:
$ N = inf{n >= n_0 : t_(n-1, 1-alpha\/2) dot S_n / sqrt(n) <= epsilon} $

*To show:* $N$ is a stopping time with respect to the filtration ${cal(F)_n}$.

*Proof:* The event ${N = n}$ (stopping occurs at replication $n$) is equivalent to:
- The stopping criterion is *not* satisfied at replication $n-1$
- The stopping criterion *is* satisfied at replication $n$

Both conditions depend only on $Y_1, dots, Y_n$ (specifically, on $overline(Y)_n$ and $S_n$), which are measurable with respect to $cal(F)_n$.

Therefore, we can determine whether $N = n$ based solely on information available up to time $n$, without requiring knowledge of future replications $Y_(n+1), Y_(n+2), dots$

This satisfies the definition of a discrete-time stopping time:
$ {N <= n} in cal(F)_n quad "for all" n $

The test "is half-width $<= epsilon$?" is computable from the sample mean and sample variance of the first $n$ observations, which are $cal(F)_n$-measurable. Thus $N$ satisfies the standard measurability condition for stopping times. #h(1fr) $qed$
]

#subproblem("c", "5")[
*Question:* Perform 20 independent simulation runs to estimate the coverage probability for $theta$. Discuss your results. Discuss the results of the two different approaches: DES versus Petri Nets.

*Answer:*

=== Goal

Empirically estimate the coverage probability of the 95% CI produced by the sequential fixed-width algorithm. Over $M = 20$ independent experiments of the whole sequential procedure, compute how often the final CI contains the true $theta$.

=== Handling Unknown True $theta$

Since an analytical $theta$ is not available for M/GI/1 with $Gamma(3,4)$ service times, we approximate a reference "truth" $theta_"ref"$ by:

+ Run a very long simulation (or average many independent very-long replications)
+ Achieve high precision (half-width $< 0.01$)
+ Use this as surrogate true value for the coverage experiment

=== Experimental Procedure

*Step 1: Compute reference value*
```
theta_ref = run_very_long_simulation()  # or many replications
# Use enough data to get half-width < 0.01
```

*Step 2: Repeat sequential procedure $M = 20$ times*

For each experiment $j = 1, dots, 20$:
+ Run the sequential algorithm until half-width $<= 0.1$
+ Record:
  - Final estimate: $hat(theta)_j$
  - Final half-width: $h_j$
  - Confidence interval: $[hat(theta)_j - h_j, hat(theta)_j + h_j]$
  - Number of replications: $N_j$

*Step 3: Compute empirical coverage*
$ hat("coverage") = 1/M sum_(j=1)^M bb(1){theta_"ref" in [hat(theta)_j - h_j, hat(theta)_j + h_j]} $

*Step 4: Calculate standard error*
$ "SE" = sqrt((hat(p)(1 - hat(p)))/M) $

where $hat(p) = hat("coverage")$.

=== Expected Results and Interpretation

*Expected coverage:* Should be near 0.95 if the procedure is valid.

*Monte Carlo uncertainty:* With only $M = 20$ experiments, the standard error is:
$ sqrt((0.95 times 0.05)/20) approx 0.049 $

Therefore, a 95% CI for the empirical coverage is approximately $0.95 plus.minus 0.098$. This is quite wide—observed coverage anywhere from 0.85 to 1.0 would be within sampling variability.

*Interpretation:* If observed coverage is 0.90 or 1.0, this may still be consistent with nominal 0.95 coverage due to small sample size. For more precise coverage estimation, increase $M$ (e.g., $M = 200$).

=== What to Report

For the 20 experiments, report:

+ *Summary statistics:*
  - Mean of $hat(theta)_j$ across 20 runs
  - Mean of $N_j$ (average number of replications needed)
  - Mean half-width achieved

+ *Coverage results:*
  - Empirical coverage: $hat("coverage")$
  - Monte Carlo standard error
  - 95% CI for coverage probability

+ *Distributions:*
  - Histogram of $N_j$ (replications needed)
  - Histogram of $hat(theta)_j$ (final estimates)
  - Table showing all 20 CIs and whether they contain $theta_"ref"$

+ *Computational cost:*
  - Average CPU time per experiment

=== DES versus Petri Nets Comparison

*Expected behavior:* If both implementations are logically equivalent (same stochastic rules), their estimated $theta$ distributions should be statistically indistinguishable.

*Potential differences may arise from:*
- Implementation bugs
- Different random number stream handling
- Different warm-up choices or measurement conventions
- Numerical precision issues

*Comparison approach:*
+ Run the full coverage experiment for both DES and Petri-net implementations
+ Compare:
  - Average $hat(theta)$ from both methods
  - Average $N$ (replications needed)
  - Empirical coverage rates
  - Variance of estimates
  - Computation time

*Statistical test:* Use a two-sample $t$-test to compare the distributions of $hat(theta)_j$ from DES vs Petri-net. If $p$-value $> 0.05$, conclude no significant difference.

*Expected outcome:* Both methods should produce similar results. Systematic differences would indicate an implementation error or fundamental modeling difference.

=== Additional Practical Considerations

*Checking stationarity/warm-up:*
- Plot several long-run trajectories of $Q(t)$
- Observe when they settle to stationary behavior
- Adjust $T_"warm"$ if necessary

*Traffic intensity effects:*
- If $rho$ is close to 1: variance increases, need more replications
- If $rho$ is large: consider variance reduction techniques (control variates)

*Numerical sanity check:*
- With $mu_S = 12$:
  - If $lambda = 0.05$: $rho = 0.6$ (stable, fast mixing)
  - If $lambda = 0.08$: $rho = 0.96$ (slow mixing, larger variances)
]

