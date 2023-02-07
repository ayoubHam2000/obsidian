# UDP
UDP (User Datagram Protocol) is a transport layer protocol in the Internet protocol suite that provides a low-latency, low-overhead method of transmitting data in packets over an IP network. Unlike TCP, UDP does not guarantee reliable delivery of data, does not guarantee order of delivery, and does not provide flow control. It is often used for real-time applications, such as video and audio streaming, online gaming, and Internet of Things (IoT) devices, where the loss of some data packets is acceptable.

## UDP client
UDP is a connectionless protocol. Therefore, no connection is established before sending data. A UDP connection is never established. With UDP, data is simply sent and received. We can call **connect()** and then **send()**, but the socket API provides an easier way for UDP sockets in the form of the **sendto()**

So, a UDP client can be structured in two different ways, depending on whether you use **connect()**, **send()**, and **recv()**, or instead use **sendto()** and **recvfrom()**.

## UDP server

Programming a UDP server is a bit different than TCP. TCP requires managing a socket for each peer connection. With UDP, our program only needs one socket. That one socket can communicate with any number of peers.

While the TCP program flow required us to use **listen()** and **accept()** to wait for and establish new connections, these functions are not used with UDP. Our UDP server simply binds to the local address, and then it can immediately start sending and receiving data.

With either a TCP or UDP server, we use **select()** when we need to check/wait for incoming data. The difference is that a *TCP Server* using **select()** is likely monitoring many separate sockets, while a *UDP Server* often only needs to monitor one socket. If your program uses both TCP and UDP sockets, you can monitor them all with only one call to **select()**.
![[Screen Shot 2023-02-07 at 11.52.09 AM.png]]

Here is where the UDP server diverges from the TCP server. Once the local address is bound, we can simply start to receive data. There is no need to call **listen()** or **accept()**. We listen for incoming data using **recvfrom()**, as shown here:

## Notes

* getaddrinfo(0, "8080", &hints, &bind_address); what 0 means in this line ?
* what it can be used instead of 0 in a UDP server

Instead of using "0" as the hostname or IP address in the first argument to **getaddrinfo()** in a UDP server, you can use the IP address or hostname of the local host if you want the server to listen on a specific IP address or hostname. For example, you can use "localhost" or "127.0.0.1" to bind the server to the loopback interface.

If you want the server to listen on all available network interfaces, you can use the constant "INADDR_ANY" instead of "0". This is equivalent to using a null pointer and is often used in server applications that need to listen on all available network interfaces. The constant is defined in the header file "netinet/in.h".

For example, the following line of code will bind a UDP server to all available network interfaces:

```C
getaddrinfo(INADDR_ANY, "8080", &hints, &bind_address);
```

----

Once we've received data, we can print it out. Keep in mind that the data may not be null terminated. It can be safely printed with the %.*s printf() format specifier, as shown in the following code
```C
printf("Received (%d bytes): %.*s\n",
               bytes_received, bytes_received, read);
```
---

The last argument to getnameinfo() **(NI_NUMERICHOST | NI_NUMERICSERV)** tells **getnameinfo()** that we want both the client address and port number to be in numeric form

-111- It's also worth noting that the client will rarely set its local port number explicitly. So, the port number returned here by **getnameinfo()** is likely to be a high number that's chosen randomly by the client's operating system. Even if the client did set its local port number, the port number we can see here might have been changed by **network address translation (NAT)**.

* *getaddrinfo("127.0.0.1", "8080", &hints, &peer_address)* Notice that we did not set AF_INET or AF_INET6 for the client server. This  
allows getaddrinfo() to return the appropriate address for IPv4 or IPv6. In this case, it is IPv4 because the address, 127.0.0.1, is an IPv4 address.

---
-115-
* It is also worth noting that we do not get an error back if sending fails. **send()** simply tries to send a message, but if it gets lost or is misdelivered along the way, there is nothing we can do about it. If the message is important, it is up to the application protocol to implement the corrective action.
* After we've sent our data, we could reuse the same socket to send data to another address (as long as it's the same type of address, which is IPv4 in this case). We could also try to receive a reply from the UDP server by calling **recvfrom()**. 
	Note that if we did call **recvfrom()** here, we could get data from anybody that sends to us – not necessarily the server we just transmitted to.
* When we sent our data, our socket was assigned with a temporary local port number by the operating system. This local port number is called the **ephemeral port number**. From then on, our socket is essentially listening for a reply on this local port. If the local port is important, you can use **bind()** to associate a specific port before calling **send()**.
---

In this chapter, we saw that programming with UDP sockets is somewhat easier than with TCP sockets. We learned that UDP sockets don't need the **listen()**, **accept()**, or **connect()** function calls. This is mostly because **sendto()** and **recvfrom()** deal with the addresses directly. For more complicated programs, we can still use the **select()** function to see which sockets are ready for I/O.