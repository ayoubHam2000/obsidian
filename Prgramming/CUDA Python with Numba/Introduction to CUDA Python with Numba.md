

The Numba compiler is typically enabled by applying a function decorator to a Python function. Decorators are function modifiers that transform the Python functions they decorate, using a very simple syntax. Here we will use Numba's CPU compilation decorator `@jit`

```python
# jit
# timeit
# py_func

@jit
def hypot(x, y):
	pass

%timeit hypot.py_func(3.0, 4.0)
```

Numba cannot compile all Python code. Some functions don't have a Numba-translation, and some kinds of Python types can't be efficiently compiled at all (yet). For example, Numba does not support dictionaries (as of this writing).

Object mode exists to enable other Numba functionality, but in many cases, you want Numba to tell you if type inference fails.


**Using `nopython` mode is the recommended and best practice way to use `jit` as it leads to the best performance.**

Numba provides another decorator `njit` which is an alias for `jit(nopython=True)`:



```python
from numba import vectorize

@vectorize
def add_ten(num):
	return num + 10 

# This scalar operation will be performed on each element
```

```python
nums = np.arange(10)

add_ten(nums) # pass the whole array into the ufunc, it performs the operation on each element
```

We are generating a ufunc that uses CUDA on the GPU with the addition of giving an **explicit type signature** and setting the `target` attribute.
```python
'return_value_type(argument1_value_type, argument2_value_type, ...)'
```

```python
# Type signature and target are required for the GPU

@vectorize(['int64(int64, int64)'], target='cuda') 
def add_ufunc(x, y):
	return x + y
```

... but 64-bit floating point data types may have a significant performance cost on the GPU, depending on the GPU type.
.... **Please note:** Not all NumPy code will work on the GPU, and, as in the following example, we will need to use the `math` library's `pi` and `exp` instead of NumPy's.


```python
from numba import cuda

@cuda.jit(device=True)
def polar_to_cartesian(rho, theta):
    x = rho * math.cos(theta)
    y = rho * math.sin(theta)
    return x, y

@vectorize(['float32(float32, float32, float32, float32)'], target='cuda')
def polar_distance(rho1, theta1, rho2, theta2):
    x1, y1 = polar_to_cartesian(rho1, theta1) # We can use device functions inside our GPU ufuncs
    x2, y2 = polar_to_cartesian(rho2, theta2)
    
    return ((x1 - x2)**2 + (y1 - y2)**2)**0.5
```

Note that the CUDA compiler aggressively inlines device functions, so there is generally no overhead for function calls. Similarly, the "tuple" returned by `polar_to_cartesian` is not actually created as a Python object, but represented temporarily as a struct, which is then optimized away by the compiler.

#### Allowed Python on the GPU

Compared to Numba on the CPU (which is already limited), Numba on the GPU has more limitations. Supported Python includes:

- `if`/`elif`/`else`
- `while` and `for` loops
- Basic math operators
- Selected functions from the `math` and `cmath` modules
- Tuples

#### Managing GPU Memory

With this implicit data transfer Numba, acting conservatively, will automatically transfer the data back to the CPU after processing. As you can imagine, this is a very time intensive operation.

**High Priority**: Minimize data transfer between the host and the device, even if it means running some kernels on the device that do not show performance gains when compared with running them on the host CPU.

The way to do this is to create **CUDA Device Arrays** and pass them to our GPU functions. Device arrays will not be automatically transfered back to the host after processing, and can be reused as we wish on the device before ultimately, and only if necessary, sending them, or parts of them, back to the host.


```python
from numba import cuda

x_device = cuda.to_device(x)
y_device = cuda.to_device(y)

print(x_device)
print(x_device.shape)
print(x_device.dtype)

@vectorize(['float32(float32, float32)'], target='cuda')
def add_ufunc(x, y):
    return x + y

%timeit add_ufunc(x_device, y_device)

```

We are, however, still allocating a device array for the output of the ufunc and copying it back to the host, even though in the cell above we are not actually assigning the array to a variable. To avoid this, we can create the output array with the [`numba.cuda.device_array()`](https://colab.research.google.com/corgiredirector?site=https%3A%2F%2Fnumba.pydata.org%2Fnumba-doc%2Fdev%2Fcuda-reference%2Fmemory.html%23numba.cuda.device_array) function:

```python
out_device = cuda.device_array(shape=(n,), dtype=np.float32)
# does not initialize the contents, like np.empty()
```

```python
%timeit add_ufunc(x_device, y_device, out=out_device)
```

```python
out_host = out_device.copy_to_host()

print(out_host[:10])
```