* Befor calling select function, we must first add our sockets into an <font style="color:red"> fd_set</font> 
* **select()** also requires that we pass a number that's larger than the largest socket + 1 in linux