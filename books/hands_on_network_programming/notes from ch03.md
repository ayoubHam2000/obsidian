
* trying to multiplexing socket connections
	* it can be using polling with non blocking sockets operation using flags
	* it can be by multithreading
	* using **select** function



//----

A common mistake beginners make is assuming that any data passed into send() can be read by recv() on the other end in the same amount. In reality, sending data is similar to writing and reading from a file. If we write 10 bytes to a file, followed by another 10 bytes, then the file has 20 bytes of data. If the file is to be read later, we could read 5 bytes and 15 bytes, or we could read all 20 bytes at once, and so on. In any case, we have no way of knowing that the file was written in two 10 byte chunks.

Using send() and recv() works the same way. If you send() 20 bytes, it's not possible to tell how many recv() calls these bytes are partitioned into. It is possible that one call to recv() could return all 20 bytes, but it is also possible that a first call to recv() returns 16 bytes and that a second call to recv() is needed to get the last 4 bytes.

We will cover techniques for dealing with recv() buffering in Section 2, An Overview of
Application Layer Protocols, of this book.

// ----

For more complicated protocols where this is needed, we have to buffer data from recv() until a suitable amount is available to interpret. For TCP peers that are handling large amounts of data, buffering to send() is also necessary

//------

In this chapter's TCP server code section, we ignored the possibility that send() could block or be interrupted. In a fully robust application, what we need to do is compare the return value from send() with the number of bytes that we tried to send. If the number of bytes actually sent is less than requested, we should use select() to determine when the socket is ready to accept new data, and then call send() with the remaining data. As you can imagine, this can become a bit complicated when keeping track of multiple sockets.

Chapter 13, Socket Programming Tips and Pitfalls, addresses concerns regarding the send() function's blocking behavior in more detail.
