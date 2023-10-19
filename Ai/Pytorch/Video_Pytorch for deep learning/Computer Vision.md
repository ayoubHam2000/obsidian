- convolutional neural network (CNN)
- python library Pillow for image processing
- MNIST database 
- cross-correlation

```
image -> convolutional layer -> Normalization (ReLu) -> Pooling | -> images -> loop <-| -> Fully connected layer 


Convolution neural network can work with images, audio and text to find patterns in the data
if your data is just as useful after swapping any of your columns with each other, than probably the convolution neural network many not work very will.
```




- PyTorch generally accepts `NCHW` (channels first) as the default for many operators.

#### batch size
- 32 is a good batch size
- But since this is a value you can set (a **hyperparameter**) you can try all different kinds of values, though generally powers of 2 are used most often (e.g. 32, 64, 128, 256, 512).


#### I used a a GPU but my model didn't train faster, why might that be?

- There's a small bottleneck between copying data from the CPU memory (default) to the GPU memory.
- There's a small bottleneck between copying data from the CPU memory (default) to the GPU memory.
- But for larger datasets and models, the speed of computing the GPU can offer usually far outweighs the cost of getting the data there.