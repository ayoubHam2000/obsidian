- What is Machine Learning
- Why Machine Learning
	- what deep learning is good for
		- Problems with long lists of rules
		- Continually changing environments
		- Discovering insight within large collection of data
- What deep learning is not good for
	- When errors are unacceptable
	- When you don't have much data
	- When you need explain-ability 
	- when the traditional approach is a better one.
- Machine learning vs Deep learning
	- Machine learning -> structure data
		- Random forest
		- Gradient boosted models
		- Naive Bayes
		- Nearest neighbour
		- support vector machine
		- Linear regression
		- Logistic regression
		- Decision tree
		- SVM algorithm
		- KNN
		- K-means
		- Dimensionality reduction
		Since the advent of deep learning these are often referred to as 'shallow algorithm'
	- Deep learning -> unstructured data
		- Neural network
		- Fully connected neural network
		- Convolutional neural network CNN
		- Recurrent neural network RNN
		- Transformer
- Types of machine learning algorithms
	- Supervised learning
		- Decision Trees
		- Support Vector Machine
		- Random forests
		- Naive Bayes
	- Unsupervised learning
		- K-means
		- Hierarchical clustering
		- Dimensionality Reduction 
	- Semi-supervised learning
	- Reinforcement learning
- What are neural networks is ?
- [[Why Deep Learning]]
- What is pytorch
	- Most popular research deep learning framework
	- write fast deep learning code in python (able to run on a GPU/many GPUs)
	- Able to access many pre-build deep learning models
	- originally designed and used in-house by Facebook/Mata
	- Open source and used by many companies such Tesla, Microsoft, OpenAi
- Why pytorch
- what is GPU / TPU
- pytorch reproducibility
- rundom seed
- device agnostic code
- Gradient descent
- BackPropagation
- Loss function / Cost function / Criterion
- Hyperparamater
- Convergance of gradient descent 
- Gradient descent
	- **Batch Gradient Descent**
	- **Stochastic Gradient Descent**
	-  **Mini-Batch Gradient Descent**
- Training a neural network
	- how large should the **learning rate** be?
	- is **stochastic** gradient descent the best way ? Are there other ways ?
		- batch gradient descent
			- mini-batch gradient descent
	- What about different types of non-linear **activation function**
		- Sigmoid
		- ReLU
		- Tanh
	- what about the **initial values** for the weights and biases ? 
	- how do we know when to **stop training** the neural network ?
	- what about **testing** our model ?

![[Screenshot from 2023-10-01 15-46-22.png]]

#### Regularization

- Technique that constrains our optimization problem to discourage complex models.
- Improve generalization of our model on unseen data
- 1. Dropout
	- During training, randomly set some activation to 0
- 2. Early stopping
	- Stop training before we have chance to overfit


#### Metrics

- https://willkoehrsen.github.io/statistics/learning/beyond-accuracy-precision-and-recall/
	- accuracy is not good for -> imbalanced classification problem.
	- The F1 score is the harmonic mean of precision and recall taking both metrics into account
	- Fβ metric where β can be adjusted to give more weight to either recall or precision.
	- The **Fowlkes–Mallows index**
	- the ROC curve shows how the recall vs precision relationship changes as we vary the threshold for identifying a positive in our model. The threshold represents the value above which a data point is considered in the positive class

#### Classification

- logits layer
- softmax
- binary cross entropy (loss fun) 
- categorical cross entropy (loss fun)
	- entropy
	- KL Divergence
- SGD
- Adam
	- AdaGrad
	- SGD with momentum
	- RMSProp
- sigmoid activation function 
- classification evaluation metrics
	- Accuracy
	- Precision
	- Recall
	- F1-score
	- Confusion matrix
	- Classification report
![[Screen Shot 2023-10-15 at 11.43.11 AM.png]]


## Computer Vision

![[Computer Vision]]

## Functions and methods

[[functions and methods]]

[[Geometric series]]

## keywords

- patterns / embedding / weights / feature representation / feature vector  
- Natural language processing NLP
- TPU
- CUDA
- feed Forward Neural Network
- Activation Function like segmoid and ReLU
- [[Epoch]]
## Notes

- Anything that you can turn it into number
- Indexing with pytorch is similar of indexing with NumPy
- If tensor is on the GPU can't transform it to the Numpy

## Links

https://www.youtube.com/watch?v=V_xro1bcAuA
https://paperswithcode.com/
https://github.com/ritchieng/the-incredible-pytorch
https://www.learnpytorch.io/
https://github.com/mrdbourke/pytorch-deep-learning
https://realpython.com/python-classes/

https://pytorch.org/docs/stable/nn.html#loss-functions
https://pytorch.org/docs/stable/optim.html?highlight=optimizer#torch.optim.Optimizer

https://www.youtube.com/watch?v=KuXjwB4LzSA # But what is a convolution?
links in:
https://www.youtube.com/watch?v=IHZwWFHWa-w&list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi&index=2

How Deep Neural Networks Work - Full Course for Beginners
https://www.youtube.com/watch?v=dPWYUELwIdM&t=2867s

Lecture 6: Backpropagation
https://www.youtube.com/watch?v=dB-u77Y5a6A

Back Propagation in training neural networks step by step
https://www.youtube.com/watch?v=-zI1bldB8to

Neural networks 3blue1brown
https://www.youtube.com/playlist?list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi

TensorFlow Playground website
https://playground.tensorflow.org/

Tensors
https://www.youtube.com/watch?v=bpG3gqDM80w

Odds and Log(Odds), Clearly Explained!!! - logit
https://www.youtube.com/watch?v=ARfXDSkQf1Y

L8.4 Logits and Cross Entropy
https://www.youtube.com/watch?v=icQaFxKa_J0

#### Metric
Recall, accuracy, precesion
https://www.youtube.com/watch?v=qWfzIYCvBqo
https://www.youtube.com/watch?v=BYQQlCVt4aE
https://www.analyticsvidhya.com/blog/2020/09/precision-recall-machine-learning/
https://www.evidentlyai.com/classification-metrics/accuracy-precision-recall
confusion matrix
https://www.youtube.com/watch?v=Kdsp6soqA7o
Sensitivity and Specificity
https://www.youtube.com/watch?v=vP06aMoz4v8
ROC (receiver operator characteristic graph ) and AUC (the area under the curve )
https://www.youtube.com/watch?v=4jRBRDbJemM

#### functions
https://en.wikipedia.org/wiki/Activation_function#Table_of_activation_functions
softmax
https://www.youtube.com/watch?v=p-6wUOXaVqs
cross entropy
https://www.youtube.com/watch?v=6ArSys5qHAU&t=3s

#### Entropy
https://www.youtube.com/watch?v=YtebGVx-Fxw
Mutual Information
#### Adam & AdaGrad & AdaDelta…
https://medium.com/@nishantnikhil/adam-optimizer-notes-ddac4fd7218
https://www.youtube.com/watch?v=5KyxlN3M7HQ
https://www.youtube.com/watch?v=NE88eqLngkg 
https://www.youtube.com/watch?v=7m8f0hP8Fzo
https://www.youtube.com/watch?v=iudXf5n_3ro

#### Lectures

MIT Introduction to Deep Learning (2022) | 6.S191
https://www.youtube.com/playlist?list=PLtBw6njQRU-rwp5__7C0oIVt26ZgjG9NI
http://introtodeeplearning.com/
#### youtube channels

https://www.youtube.com/@statquest
https://www.youtube.com/@Mutual_Information/videos
https://www.youtube.com/@elliotwaite/featured

#### Convolutional Neural Networks

https://www.youtube.com/watch?v=YRhxdVk_sIs
https://www.youtube.com/watch?v=Lakz2MoHy6o
In Depth Explanation | Convolutional Neural Networks | From Scratch
https://www.youtube.com/watch?v=jDe5BAsT2-Y
cnn-explainer
https://poloclub.github.io/cnn-explainer/
#### Other

https://www.nutrify.app/