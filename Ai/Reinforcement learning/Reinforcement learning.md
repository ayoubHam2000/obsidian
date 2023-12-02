- https://www.youtube.com/playlist?list=PLZbbT5o_s2xoWNVdDudn51XM8lOuZ_Njv
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


#### Exploration vs. exploitation

- Exploration_ is the act of exploring the environment to find out information about it. 
- Exploitation_ is the act of exploiting the information that is already known about the environment in order to maximize the return.
- To get this balance between exploitation and exploration, we use what is called an _epsilon greedy strategy_


### Epsilon greedy strategy

- To get this balance between exploitation and exploration, we use what is called an _epsilon greedy strategy_. With this strategy, we define an _exploration rate_ $\epsilon$  that we initially set to $1$. This exploration rate is the probability that our agent will explore the environment rather than exploit it. With $\epsilon=1$ , it is $100\%$ certain that the agent will start out by exploring the environment.
- As the agent learns more about the environment, at the start of each new episode, $\epsilon$ will decay by some rate.
- To determine whether the agent will choose exploration or exploitation at each time step, we generate a random number between 0 and 1. If this number is greater than epsilon, then the agent will choose its next action via exploitation

Alright, so after the lizard takes an action, it observes the next state, the reward gained from its action, and updates the Q-value in the Q-table for the action it took from the previous state.
##### Calculating the new Q-value

- The *learning rate* is a number between 0 and 1, which can be thought of as how quickly the agent abandons the previous Q-value in the Q-table for a given state-action pair for the new Q-value.
$$ q^{new}(s, a) = (1-\alpha).q^{old}(s, a) + \alpha.(R_{t+1} + \gamma. \underset{a'}{max}.q(s',a'))$$

## Training Agent to play FrozenLake

```python
import numpy as np
import gym
import random
import time
from IPython.display import clear_output

env = gym.make('FrozenLake-v1', render_mode='ansi')
action_space_size = env.action_space.n
state_space_size = env.observation_space.n

q_table = np.zeros((state_space_size, action_space_size))

num_episodes = 10000
max_steps_per_episode = 100

learning_rate = 0.1
discount_rate = 0.99

exploration_rate = 1
max_exploration_rate = 1
min_exploration_rate = 0.01
exploration_decay_rate = 0.01
```

```python
rewards_all_episodes = []

for episode in range(num_episodes):
  state = env.reset()[0]
  done = False
  rewards_current_episode = 0

  for step in range(max_steps_per_episode):
    exploration_rate_threshold = random.uniform(0, 1)
    if exploration_rate_threshold > exploration_rate:
      action = np.argmax(q_table[state,:]) 
    else: 
      action = env.action_space.sample()
    new_state, reward, done, truncated, info = env.step(action)
    q_table[state, action] = q_table[state, action] * (1 - learning_rate) + \
      learning_rate * (reward + discount_rate * np.max(q_table[new_state, :]))
    state = new_state
    rewards_current_episode += reward
    if done == True: 
      break
  # Exploration rate decay
  exploration_rate = min_exploration_rate + \
    (max_exploration_rate - min_exploration_rate) * np.exp(-exploration_decay_rate*episode)
  rewards_all_episodes.append(rewards_current_episode)

print(rewards_all_episodes)
print(sum(rewards_all_episodes) / num_episodes)
rewards_per_thousand_episodes = np.split(np.array(rewards_all_episodes), num_episodes/1000)
count = 1000
print("********Average reward per thousand episodes********\n")
for r in rewards_per_thousand_episodes:
    print(count, ": ", str(sum(r/1000)))
    count += 1000
```

```python
for episode in range(3):
  state = env.reset()[0]
  done = False
  print("*****EPISODE ", episode+1, "*****\n\n\n\n")
  time.sleep(1)

  for step in range(max_steps_per_episode):        
    clear_output(wait=True)
    print(env.render())
    time.sleep(0.3)

    action = np.argmax(q_table[state,:])        
    new_state, reward, done, truncated, info = env.step(action)

    if done:
      clear_output(wait=True)
      print(env.render())
      if reward == 1:
        print("****You reached the goal!****")
        time.sleep(3)
      else:
        print("****You fell through a hole!****")
        time.sleep(3)
        clear_output(wait=True)
      break
    state = new_state

    # Set new state

env.close()
```

## Deep Q-learning

- Q-learning algorithm struggles when dealing with high-dimensional or continuous state/action spaces
- can lead to suboptimal policies


- Suppose we have some arbitrary deep neural network that accepts states from a given environment as input. For each given state input, the network outputs estimated Q-values for each action that can be taken from that state. The objective of this network is to approximate the optimal Q-function, and remember that the optimal Q-function will satisfy the Bellman equation
$$ q_*(s, a) = E[R_{t+1} + \gamma \underset{a'}{max}\ q_*(s', a')]$$
- With this in mind, the [loss](https://deeplizard.com/learn/video/Skc8nqJirJg) from the network is calculated by comparing the outputted Q-values to the target Q-values from the right hand side of the Bellman equation, and as with any network, the objective here is to minimize this loss.
![[Screenshot from 2023-11-22 14-52-39.png]]
 - So, take a second now to think about how we previously used the Bellman equation to [compute and update Q-values in our Q-table](https://deeplizard.com/learn/video/mo96Nqlo1L8) in order to find the optimal Q-function. Now, with deep Q-learning, our network will make use of the Bellman equation to estimate the Q-values to find the optimal Q-function. So, we're still solving the same general problem here, just with a different algorithm. Rather than making use of value iteration to solve the problem, we're now using a deep neural network.


#### Replay Memory Explained - Experience for Deep Q-Network Training

With deep Q-networks, we often utilize this technique called _experience replay_ during training. With experience replay, we store the agent's experiences at each time step in a data set called the _replay memory_. We represent the agent's experience at time $t$ as $e_t$

$$ e_t = (s_t, a_t, r_{t+1}, s_{t+1}) $$

- This replay memory data set is what we'll randomly sample from to train the network. 
- The act of gaining experience and sampling from the replay memory that stores these experience is called **experience replay**.
- Why would we choose to train the network on random samples from replay memory, rather than just providing the network with the sequential experiences as they occur in the environment?

=> `A key reason for using replay memory is to break the correlation between consecutive samples.`

- If the network learned only from consecutive samples of experience as they occurred sequentially in the environment, the samples would be highly correlated and would therefore lead to inefficient learning. Taking random samples from replay memory breaks this correlation.
1. Initialize replay memory capacity.
2. Initialize the network with random weights.
3. Clone the policy network, and call it the target network
4. _For each episode:_
	1. Initialize the starting state.
	2. _For each time step:_
		1. Select an action.
			- _Via exploration or exploitation_
	3. Execute selected action in an emulator.
	4. Observe reward and next state.
	5. Store experience in replay memory.
	6. Preprocess stated from batch
	7. Pass batch of preprocessed states to policy network
	8. Calculate loss between output Q-value and target Q-values
		1. Requires a second pass to the network for the next state
	9. Gradient descent updates weights in the policy network to minimize loss.
		1. After $x$ times steps, weights in the target network are updated to the weights in the policy network