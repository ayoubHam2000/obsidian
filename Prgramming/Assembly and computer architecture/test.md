The meaning of `test` is to AND the arguments together, and check the result for zero. So this code tests if EAX is zero or not. `je` will jump if zero.

```
testl %eax, %eax
```