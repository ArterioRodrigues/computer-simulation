=== Exercise -1
The state space is S = {0, 1, 2, ... N}
Class 1: {0}
- state 0 is absorbing
- stays forever

Class 2: {1, 2, 3... N- 1}
- These are transient states

Class N:
- state N is absorbing

=== Exercise -2

The states in A = {r+1, ... N} are all absorbing state because:
1. The identity block I ensures $P_{j,j}$= 1 for all j $in$ A
2. The zero block ) ensures no return to transient staes T
3. Each absorbing state forms its own closed commuincation class

=== Exercise -3
T is a stopping time because at each time n, we can determine whether t =n using only
the history of the chain up to time n

T is adapted to the natural filtration  because the deecision "have we been absorbed
yet?" depends only on the past and present states, not on future states.

=== Exercise 4

For this problem we should model $X_n$ as a  *discrete-time Markov Chain* where
state represents Theseus position in the maze at time n.

State space: S = {0, 1, 2, E}

State 0: Initial Chamber \
State 1: Fork in the path \
State 2: Right Path \
State E: Exit

Transisition Probabilities:

State 0 -> State 2: 1/2 \
State 0 -> State 1: 1/2 \

State 1 -> State E: 1/3 \
State 1 -> State 0: 2/3 \

State 2 -> State 0: 1 \
State E -> State E: 1\

=== Part 2
use first-step analysis approach from optimal stopping theory. \
$w_i = g(i) + sum_(j)  P_(i j) w_j$

$w_i$ = expected time to exit from state i \ 
g(i) = some immediate cost time to transition to this state.\
$P_(i j)$ = transition probability form i to j. \
$w_j$ = Expected time to exit start from state j. \ 
$sum_(j)$ = The sum of all possible next state j.

#pagebreak()
=== Exercise 5 

Absorption probability dependss only on which states you visit, not on how long you spend
in each state.

* CTP $X(*)$ *
 
Let $u_i$ = probability of eventually being absorbed into state A, starting from state i

Starting from state i:
- The process spends some random time in state i(distributed as $G_i$)
- Then jums to state j with probability $P_(i j)$
- From state j, probabilit yof absorption is $u_j$

Therefore

$u_i = sum_j P_(i j) * u_j$

*DTMC $X_n$*

Starting from state i in the discrete chain we
- jump to state j with probability $P_(i j)$
- From state j, probability of absorption is $u_j$

Therefore

$u_i = sum_j P_(i j) * u_j$

*Conculsion* 

Both continuous time and discrete time satisfy the exact same system of linear
equations with the same boundary conditions.

$u_i = u_i$ for all states i.


The distribution doesn't matter 
- where absorption occurs
- which absorbing state is reached
- the probability of absorption 

does effect
- when absorption occurs
- the rate at which transtions happens.


#pagebreak()

 === Exercise 6
First you hang out in state i then you jump to state
j with some average probability.

Let $W_i$ denote the expected time to absorption for the continuous-time process X(.)
starting from transient state i.

Using first-step analysis, we condition on the first trasition: 

$W_i$ = E[time in state i] + E[time after leaving state i | X(0) = i]

The time spent in state i has mean 1/$v_i$ by definition.

After spending time $T_i$ in state i, the process jumps to state j with probability Pij, If 
j is absorbing, no additional time is needed. If j is transisent, the expectred 
additional time is Wj.

By the law of total expectation:

E[time after leaving state i | X(0) = i]\
=$sum_j P_(i j) * E["time to absorption from" j]$ \
=$sum_j in T P_(i j) * W_j$ \


The sum is only over trasient states T since absorbing state contribute 0.)

Therefore: 

$W_i = 1/v_i + sum_j in T$   $W_j P_(i j)$

=== Exercise 7

we need to prove
- The future doesn't depends on the past only present
- it doesn't matter


=== Exercise 8


You can reach any state i, you can reach any state j in exactly n steps.
Therefore i -> j for all pairs(i, j)
This means all states communicates

All are single communicating class no separate groups.

=== Exercise 9
It oscilates back and force with o -> 1.
