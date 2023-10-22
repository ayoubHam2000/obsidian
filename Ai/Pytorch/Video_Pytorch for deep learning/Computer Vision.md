- convolutional neural network (CNN)
- python library Pillow for image processing
- MNIST database 
- cross-correlation

```
image -> convolutional layer -> Normalization (ReLu) -> Pooling | -> images -> loop <-| -> Fully connected layer 
called TinyVGG

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


#### Convolution
- For other dimensional data (such as 1D for text or 3D for 3D objects) there's also `nn.Conv1d()` and `nn.Conv3d()`.
- `in_channels` (int) - Number of channels in the input image.
- `out_channels` (int) - Number of channels produced by the convolution.
- `kernel_size` (int or tuple) - Size of the convolving kernel/filter.
- `stride` (int or tuple, optional) - How big of a step the convolving kernel takes at a time. Default: 1.
- `padding` (int, tuple, str) - Padding added to all four sides of input. Default: 0.

most common convolutional neural networks
https://www.topbots.com/important-cnn-architectures/

confmat ??



## notes

mlxtend -> library
random -> library
tqdm -> library
from timeit import default_timer as timer
pandas
numpy
scipy
matplotlib
pathlib
os
sys
