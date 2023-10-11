```
torch.tensor
torch.min
torch.max
torch.mean
torch.arange
torch.shape
torch.size
torch.type
torch.float32
torch.zeros
torch.zeros_like
torch.ones
torch.ones_like
torch.ndim
torch.reshape
torch.view
torch.stack
torch.squeeze
torch.unsqueeze
torch.permute
Indexing with pytorch is similar of indexing with NumPy
torch.numpy()
torch.Tensor.numpy()
torch.from_numpy(nparray)
If tensor is on the GPU can't transform it to the Numpy
torch.manual_seed(seed)
torch.nn.Linear
torch.cuda.is_available()

device agnostic code =>
	tensor.to(device)
	torch.tensor(..., device=device)
	tensor.device
	tensor_on_gpu.cpu().numpy()
```

## Chapter 2

![[workflow.png]]

```
from torch import nn

- get data
- splitting data into training and test sets
	- Validation Set
	- Test Set
_ Generalization : The ability for machine learning model to perform well on data it hasn't seen before

- torch.nn : contains all the of the buildings for computational graphs (a neural network can be considered a computational graph)
- torch.nn.Parameter : what our parameters should our model try and learn.
- torch.nn.Module : the base class for all neural network modules
	- if you subclass it you should overwrite forward()
- torch.optim : this where the optimizers of pytorch live, they will help with gradient descent 
- torch.utils.data.Dataset
- torch.utils.data.DataLeader


- Train model 
	- The whole idea of training a model is to move from some unknown parameters (these may be random) to some known parameters
- Loss Function
	- is function to measure how wrong your model's predictions are to the ideal outputs
- optimizer
	- Takes into account the loss of a model and adjust the model parameters

- L1Loss
	- Creates a criterion that measures the mean absolute error (MAE) between each element in the input x and target y. 
	- l(x, y) = mean({|x_1 - y_1|, ... {x_n - y_n}})
- torch.optim.GSD : Stochastic fradient descent


```


```
### PyTorch training loop

- Forward pass : The model goes through all of the training data once, performing its `forward()` function calculations. `model(x_train)`
- Calculate the loss : The model's outputs (predictions) are compared to the ground truth and evaluated to see how wrong they are. `loss = loss_fn(y_pred, y_train)`
- Zero gradients : The optimizers gradients are set to zero (they are accumulated by default) so they can be recalculated for the specific training step. `optimizer.zero_grad()`
- Perform backpropagation on the loss : Computes the gradient of the loss with respect for every model parameter to be updated (each parameter with `requires_grad=True`). This is known as **backpropagation**, hence "backwards". `loss.backward()`
- Update the optimizer (**gradient descent**) : Update the parameters with `requires_grad=True` with respect to the loss gradients in order to improve them. `optimizer.step()`
```

```
- **In-place operations** Operations that store the result into the operand are called in-place. They are denoted by a `_` suffix
```
### connection between loss.backward() and optimizer.step

- When you call `loss.backward()`, all it does is compute gradient of loss w.r.t all the parameters in loss that have `requires_grad = True` and store them in `parameter.grad` attribute for every parameter.
- Without delving too deep into the internals of PyTorch, I can offer a simplistic answer:
	Recall that when initializing `optimizer` you explicitly tell it what parameters (tensors) of the model it should be updating. The gradients are "stored" by the tensors themselves (they have a [`grad`](https://pytorch.org/docs/master/autograd.html#torch.Tensor.grad) and a [`requires_grad`](https://pytorch.org/docs/master/autograd.html#torch.Tensor.requires_grad) attributes) once you call `backward()` on the loss. After computing the gradients for all tensors in the model, calling `optimizer.step()` makes the optimizer iterate over all parameters (tensors) it is supposed to update and use their internally stored `grad` to update their values.

```
https://stackoverflow.com/questions/53975717/pytorch-connection-between-loss-backward-and-optimizer-step
```

### Why do we need to call zero_grad() in PyTorch?

```
https://stackoverflow.com/questions/48001598/why-do-we-need-to-call-zero-grad-in-pytorch
```


In [`PyTorch`](https://github.com/pytorch/pytorch), for every mini-batch during the _training_ phase, we typically want to explicitly set the gradients to zero before starting to do backpropagation (i.e., updating the _**W**eights_ and _**b**iases_) because PyTorch _accumulates the gradients_ on subsequent backward passes. This accumulating behavior is convenient while training RNNs or when we want to compute the gradient of the loss summed over multiple _mini-batches_. So, the default action has been set to [accumulate (i.e. sum) the gradients](https://pytorch.org/docs/stable/_modules/torch/autograd.html) on every `loss.backward()` call.

Because of this, when you start your training loop, ideally you should [`zero out the gradients`](https://pytorch.org/docs/stable/generated/torch.optim.Optimizer.zero_grad.html#torch.optim.Optimizer.zero_grad) so that you do the parameter update correctly. Otherwise, the gradient would be a combination of the old gradient, which you have already used to update your model parameters and the newly-computed gradient. It would therefore point in some other direction than the intended direction towards the _minimum_ (or _maximum_, in case of maximization objectives).

## Training

```python
torch.manual_seed(42)

# Set the number of epochs (how many times the model will pass over the training data)
epochs = 100

# Create empty loss lists to track values
train_loss_values = []
test_loss_values = []
epoch_count = []

for epoch in range(epochs):
    ### Training

    # Put model in training mode (this is the default state of a model)
    model_0.train()

    # 1. Forward pass on train data using the forward() method inside 
    y_pred = model_0(X_train)
    # print(y_pred)

    # 2. Calculate the loss (how different are our models predictions to the ground truth)
    loss = loss_fn(y_pred, y_train)

    # 3. Zero grad of the optimizer
    optimizer.zero_grad()

    # 4. Loss backwards
    loss.backward()

    # 5. Progress the optimizer
    optimizer.step()

    ### Testing

    # Put the model in evaluation mode
    model_0.eval()

    with torch.inference_mode():
      # 1. Forward pass on test data
      test_pred = model_0(X_test)

      # 2. Caculate loss on test data
      test_loss = loss_fn(test_pred, y_test.type(torch.float)) # predictions come in torch.float datatype, so comparisons need to be done with tensors of the same type

      # Print out what's happening
      if epoch % 10 == 0:
            epoch_count.append(epoch)
            train_loss_values.append(loss.detach().numpy())
            test_loss_values.append(test_loss.detach().numpy())
            print(f"Epoch: {epoch} | MAE Train Loss: {loss} | MAE Test Loss: {test_loss} ")
```

## Saving model

``` python
from pathlib import Path

MODEL_PATH = Path("Models")
MODEL_PATH.mkdir(parents=True, exist_ok=True)
  
MODEL_NAME = "first_model.pth"
MODEL_SAVE_PATH = MODEL_PATH / MODEL_NAME
print(f"Saving model to {MODEL_SAVE_PATH}")
torch.save(obj=model_0.state_dict(), f=MODEL_SAVE_PATH)
```

```
https://pytorch.org/tutorials/beginner/saving_loading_models.html#saving-loading-model-for-inference

torch.save(model, PATH)
# Model class must be defined somewhere
model = torch.load(PATH)
model.eval()

- A common PyTorch convention is to save models using either a `.pt` or `.pth` file extension.

- Remember that you must call `model.eval()` to set dropout and batch normalization layers to evaluation mode before running inference. Failing to do this will yield inconsistent inference results.
```

#### Export/Load Model in TorchScript Format

```python
model_scripted = torch.jit.script(model) # Export to TorchScript
model_scripted.save('model_scripted.pt') # Save

model = torch.jit.load('model_scripted.pt')
model.eval()

# Using the TorchScript format, you will be able to load the exported model and run inference without defining the model class.

# can be run in Python as well as in a high performance environment like C++
```

#### Saving & Loading a General Checkpoint for Inference and/or Resuming Training

```python
torch.save({
            'epoch': epoch,
            'model_state_dict': model.state_dict(),
            'optimizer_state_dict': optimizer.state_dict(),
            'loss': loss,
            ...
            }, PATH)

model = TheModelClass(*args, **kwargs)
optimizer = TheOptimizerClass(*args, **kwargs)

checkpoint = torch.load(PATH)
model.load_state_dict(checkpoint['model_state_dict'])
optimizer.load_state_dict(checkpoint['optimizer_state_dict'])
epoch = checkpoint['epoch']
loss = checkpoint['loss']

model.eval()
# - or -
model.train()

# See also
## Saving Multiple Models in One File 
### Save on GPU, Load on CPU
### Save on GPU, Load on GPU
### Save on CPU, Load on GPU
```

## Classification Ch3

- BCELoss binarey cross entropy
- BCEWithLogitsLoss -> sigmoid function buit-in

```
https://github.com/mrdbourke/pytorch-deep-learning/blob/main/02_pytorch_classification.ipynb

- To recap, we converted our model's raw outputs (logits) to predicition probabilities using a sigmoid activation function.
- logits = log(p / (1 - p))
- p = sig(z)
- rev(sig(z)) = logits(z)
- logits(sig(z)) = z
```

```
Improve a model

- Add more layers
- Add nodes
- more training
- changing the activation functions
- changing the learning rate
- change the loss function

-> _because you can adjust all of these by hand, they're referred to as_ _hyperparameters_*.

-> the missing piece about classification is no-linearity
	-> What pattern can you draw if you were given an inifinite amount of straight and non-straight lines ?
	
```

```
A few more classification metrics (to evaluate our classification model)

Accuracy - out of 100 samples, how many does our model get right ? 
Precision
Recall
F1-score
Confusion matrix
classification report
```
## Indexing 

```
select all the target of a dimension
x[:, :, 0]


```