	
- What is machine learning
- application of machine learning
- supervised learning
	- [[Regression]]
	- [[Classification]]
- unsupervised learning
- reinforcement learning
- Cost function
$$ J(\omega, b) = \frac{1}{2m} \sum_{1}^{m} (\hat y_i - y_i)^2  $$ $$ \hat y_i = f_{\omega, b} (x_i)$$ 

to
$$ minimize\ J(\omega, b) $$

- loss function
- gradient descent
- learning rate
- batch gradient descent

- Model
$$ f_{\vec{w}, b}(\vec{x}) = w_1x_1 + w_2x_2 +\ ... \ + w_nx_n + b $$
$$ \vec{x} = [x_1, x_2, ..., x_n] \ \ \ \vec{w} = [w_1, w_2, ..., w_n] $$ $$ f_{\vec{w}, b}(\vec{x}) = \vec{w} . \vec{x} + b $$
- vectorization -> can be benefit from parallelism
- gradient descent
$$

\begin{aligned}
w_i = w_i - \frac{\partial J(w_1, w_2, ..., w_n, b)}{\partial w_i}\\
b = b - \frac{\partial J(w_1, w_2, ..., w_n, b)}{\partial b}\\
\frac{\partial J}{\partial \omega} = \frac{1}{m}\sum_{i=0}^{m-1} (f_{\omega, b}(x^{(i)}) - y^{(i)}) * x^{(i)} \\
\frac{\partial J}{\partial b} = \frac{1}{m}\sum_{i=0}^{m-1} (f_{\omega, b}(x^{(i)}) - y^{(i)})

\end{aligned}

$$
![[Screenshot from 2023-11-01 13-23-43.png]]

- mean normalization
$$ x = \frac{x - mean}{max - min} $$
z-score normalization
$$ x = \frac{x - mean }{standard\ deviation} $$
- https://developers.google.com/machine-learning/data-prep/transform/normalization

- adjusting the learning rate
	- not very large
	- not very small
- feature engineering
	- Using intuition to design new feature by transforming or combining original features.
- Polynomial regression and feature engineering => by using square root of x or x cube or ...

- logistic regression
- decision boundary and non-linear decision boundary.
- logistic function outputs between 0 and 1 like when using sigmoid function

![[Screenshot from 2023-11-02 10-38-46.png]]
### Cost vs Loss

- Loss function: Used when we refer to the error for a single training example. Cost function: Used to refer to an average of the loss functions over an entire training data.

![[Screenshot from 2023-11-02 10-46-10.png]]
![[Screenshot from 2023-11-02 10-51-42.png]]
![[Screenshot from 2023-11-02 10-52-03.png]]

This is defined: 
* $loss(f_{\mathbf{w},b}(\mathbf{x}^{(i)}), y^{(i)})$ is the cost for a single data point, which is:

$$
\begin{equation}
  loss(f_{\mathbf{w},b}(\mathbf{x}^{(i)}), y^{(i)}) = \begin{cases}
    - \log\left(f_{\mathbf{w},b}\left( \mathbf{x}^{(i)} \right) \right) & \text{if $y^{(i)}=1$}\\
    - \log \left( 1 - f_{\mathbf{w},b}\left( \mathbf{x}^{(i)} \right) \right) & \text{if $y^{(i)}=0$}
  \end{cases}
\end{equation}
$$


*  $f_{\mathbf{w},b}(\mathbf{x}^{(i)})$ is the model's prediction, while $y^{(i)}$ is the target value.

*  $f_{\mathbf{w},b}(\mathbf{x}^{(i)}) = g(\mathbf{w} \cdot\mathbf{x}^{(i)}+b)$ where function $g$ is the sigmoid function.

$$loss(f_{\mathbf{w},b}(\mathbf{x}^{(i)}), y^{(i)}) = (-y^{(i)} \log\left(f_{\mathbf{w},b}\left( \mathbf{x}^{(i)} \right) \right) - \left( 1 - y^{(i)}\right) \log \left( 1 - f_{\mathbf{w},b}\left( \mathbf{x}^{(i)} \right) \right)$$

	![[Screenshot from 2023-11-15 10-00-22.png]]

- This curve is well suited to gradient descent! It does not have plateaus


```python
#Logistic Regression

from sklearn.linear_model import LogisticRegression

lr_model = LogisticRegression()
lr_model.fit(X, y)
lr_model.predict(X)
lr_model.score(X, y)

```
$$ L(f_{\vec{w}, b}(\vec{x^{(i)}}), y^{(i)}) = -y^{(i)} * log(f_{\vec{w}, b}(\vec{x^{(i)}})) - (1 - y^{(i)}) * log(1 - f_{\vec{w}, b}(\vec{x^{(i)}})) $$
$$ J(\vec{w}, b, \vec{x^{(i)}}, y^{(i)}) = \frac{1}{m} \sum_{1}^{m} [ L(f_{\vec{w}, b}(\vec{x^{(i)}}), y^{(i)}) ]$$

- The fact that the cost function squares the loss ensures that the 'error surface' is convex like a soup bowl. It will always have a minimum that can be reached by following the gradient in all dimensions. In the previous plot, because the 𝑤 and 𝑏 dimensions scale differently, this is not easy to recognize. The following plot, where 𝑤 and 𝑏 are symmetric, was shown in lecture

## Matrix representation
Each row of the matrix represents one example. When you have $m$ training examples ( $m$ is three in our example), and there are $n$ features (four in our example), $\mathbf{X}$ is a matrix with dimensions ($m$, $n$) (m rows, n columns).


$$\mathbf{X} = 
\begin{pmatrix}
 x^{(0)}_0 & x^{(0)}_1 & \cdots & x^{(0)}_{n-1} \\ 
 x^{(1)}_0 & x^{(1)}_1 & \cdots & x^{(1)}_{n-1} \\
 \cdots \\
 x^{(m-1)}_0 & x^{(m-1)}_1 & \cdots & x^{(m-1)}_{n-1} 
\end{pmatrix}
$$
notation:
- $\mathbf{x}^{(i)}$ is vector containing example  $\mathbf{x}^{(i)}$ $= (x^{(i)}_0, x^{(i)}_1, \cdots,x^{(i)}_{n-1})$
- $x^{(i)}_j$ is element j in example.





### Overfitting

![[Screenshot from 2023-11-04 14-38-59.png]]
- high bias
- generalization
- high variance
- insufficient data and selecting many features can cause overfitting.
	- Regularization can reduce overfitting by:
		- Reduce the size of parameter **i** 
		- keep all the futures
		- Increasing the regularization parameter lambda reduces overfitting by reducing the size of the parameters.  For some parameters that are near zero, this reduces the effect of the associated features.
		- multiplying weight by large value Lambda can make their values small daring the training hence reduce the overfitting
$$ J(\omega, b) = \frac{1}{2m} \sum_{1}^{m} (\hat y_i - y_i)^2 + \frac{\lambda}{2m} \sum_{j=1}^n w_j^2 $$

## Notes

- less weight value implies less important/correct feature, and in extreme, when the weight becomes zero or very close to zero, the associated feature is not useful in fitting the model to the data.

```python
#sklearn

from sklearn.linear_model import SGDRegressor
from sklearn.preprocessing import StandradScalar

scalar = StandardScalar()
X_norm = scalar.fit_transform(X_train)

sgdr = SGDRegressor(max_iter=1000)
sgdr.fit(X_norm, y_train)
b_norm = sgdr.intercept_
w_norm = sgdr.coef_
y_pred = sgdr.predict(X_norm)


```

## Keywords

- features
- targets
- hypothesis (function)

## Links

https://github.com/greyhatguy007/Machine-Learning-Specialization-Coursera/tree/main/C1%20-%20Supervised%20Machine%20Learning%20-%20Regression%20and%20Classification