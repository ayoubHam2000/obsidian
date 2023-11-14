- we have a set of states $S$ , a set of actions $A$, and a set of rewards $R$ 
- At each time step $t=0, 1, 2, ...$ , the agent receives some representation of the environment's state $S_t \in S$ . based on this state, the agent selects action $A_t \in A$ this gave as the state-action pair $(S_t, A_t)$.
- Time is then incremented to the next time step $t + 1$, and the environment is transitioned to a new state $S_{t+1}$. At this time, the agent receives a numerical reward $R_{t+1}$ for the action $A_t$ taken from the state $S_t$
	- $$ f(S_t, A_t) = R_{t+1} $$
- We define the probability of the transition to $s'$ with reward $r$  from taking action $a$ in state $s$ as $$ P(s', r | s, a) = Pr(S_t=s', R_{t} = r | S_{t-1} = s, A_{t-1} = a) $$
- The goal of the agent is to maximize the accumulative rewards
	- we can think of return simply as the sum of future rewards 
	- we define the $expected\ discount\ return$ as  
		- $$ G_t = \sum_{k=0}^{\inf}\gamma^{k}R_{t+k+1} $$
- what's the probability that an agent will select a specific action from a specific state.
- Policies : 
$$ s \in S,\ \pi(a|s) \ is \ the \ probability\ of\ taking\ action\ a\ in\ state\ s\ $$
- State-value function:
$$ \begin{align*} 
	\text{The sate value function for policy } \pi, \text{denoted as } v_{\pi}(s),\\
	\text{tell as how good any given state is for an agent following policiy } \pi
	\end{align*}
$$
$$ v_{\pi}(s) = E[G_t | S_t=s] $$
$$ v_{\pi}(s) = E[\sum_{k=0}^{\inf}\gamma^{k}R_{t+k+1}|S_t = s] $$
- action-value function:
	- the action value function for policy $\pi$, denoted as $q_{\pi}$, tell as how good is it for the agent to take any given action from a given state while following the policy $\pi$ 
	- $$ q_{\pi} (s,a) = E[G_t | S_t=s, A_t = a] $$
	- $$ q_{\pi}(s, a) = E[\sum_{k=0}^{\inf}\gamma^{k}R_{t+k+1}|S_t = s, A_t = a] $$

- Optimal policy:
	- A policy ${\pi}$ is considered to be better or the same as ${\pi}'$ if the expected return of $\pi$ is greater than or equal to expected return of $\pi'$ for all state.
	- $$ \pi > \pi' \text{ if and only if } v_{\pi}(s) \ge v_{\pi'}(s) for\ all\ s \in S  $$
- Optimal state-value function:
	- The Optimal state-value function is the $largest$ expected return achievable by **any policy**  $\pi$ for each sate. denoted by $v_*$ 
	- $$ v_*(s) = \underset{\pi}{max}\  v_{\pi}(s) $$
- Optimal state-value function:
	- The Optimal state-value function is the $largest$ expected return achievable by **any policy**  $\pi$ for each sate-value pair. denoted by $q_*$
	- $$ q_*(s, a) = \underset{\pi}{max}\  q_{\pi}(s, a) $$
- Bellman optimality equation for $q_*$ 
	- One fundamental property of $q_*$ is that it must satisfy the following equation.
	- $$ q_*(s, a) = E[R_{t+1} + \gamma \underset{a'}{max}\ q_*(s', a')]$$
	- It states that, for any state-action pair $(s, a)$ at time $t$, the expected return from starting in state $s$, selecting action $a$ and following the optimal policy thereafter **is going** to be the expected reward we get from taking action $a$ in state $s$ + maximum $expected\ discounted\ return$ that can be achieved from any possible next state-action pair $(s', a')$.