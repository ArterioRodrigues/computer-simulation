#set page(margin: 1in)
#set par(justify: true)
#set text(size: 11pt)
#set heading(numbering: "1.")

#align(center)[
  #text(size: 16pt, weight: "bold")[Problem Set 4 - Problem 5]
  
  #v(0.5em)
  Computer Modeling and Simulation
  
  #v(0.5em)
  M/GI/1 Queue Simulation
]

#v(1em)

= Problem 5 #text(weight: "bold", size: 10pt)[\[20 points\]]

Consider a M/GI/1 queue with Poisson arrivals of rate $lambda$ and iid service times ${S_i}$ with distribution $Gamma(3,4)$. The goal is to estimate the stationary average queue length $theta$.

== Notation and Setup

- *Interarrival rate:* $lambda$ (Poisson arrivals)
- *Service times:* $S_i tilde Gamma(3, 4)$ (shape=3, scale=4)
- *Mean service time:* $mu_S = 3 dot 4 = 12$
- *Traffic intensity:* $rho = lambda mu_S$ (require $rho < 1$ for stationarity)
- *Target:* Estimate $theta$ (stationary average queue length)
- *Confidence level:* $1 - alpha = 0.95$ (so $alpha = 0.05$)
- *Target precision:* $epsilon = 0.1$ (CI half-width)

== (a) Adaptive Algorithm for 95% CI with Half-Width ≤ 0.1 #text(weight: "bold", size: 10pt)[\[10 points\]]

=== Chosen Approach: Independent Replications with Sequential Stopping

I use *independent replications* with a *sequential fixed-width stopping rule* because:
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

== (b) Stopping Time Verification #text(weight: "bold", size: 10pt)[\[5 points\]]

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

The test "is half-width $<= epsilon$?" is computable from the sample mean and sample variance of the first $n$ observations, which are $cal(F)_n$-measurable. Thus $N$ satisfies the standard measurability condition for stopping times.

== (c) Coverage Probability Estimation #text(weight: "bold", size: 10pt)[\[5 points\]]

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

=== Summary

The independent replications approach with sequential stopping provides:
- Rigorous statistical foundation (valid $t$-based CIs)
- Natural stopping criterion (adaptive to problem difficulty)
- Clear interpretation as a stopping time
- Empirical validation through coverage probability estimation

The comparison between DES and Petri-net implementations serves as a validation check, ensuring both approaches correctly model the same queueing system.
