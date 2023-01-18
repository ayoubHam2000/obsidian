`struct sockaddr` is a structure defined in the C standard library that is used to represent a socket address. It is used as the first argument of the `bind()`, `connect()`, `accept()`, and `getaddrinfo()` functions, to specify the address and port of a socket.

The `struct sockaddr` structure contains the following fields:

-   `sa_family`: an integer that specifies the address family of the socket address, such as AF_INET for IPv4 or AF_INET6 for IPv6.
-   `sa_data`: an array of characters that contains the actual socket address. The contents of this array depend on the address family of the socket.

Here is an example of how to use the `struct sockaddr` structure to specify the address and port of a socket:
```C
#include <sys/socket.h>
#include <netinet/in.h>

int sockfd;
struct sockaddr_in addr;

// Create a socket
sockfd = socket(AF_INET, SOCK_STREAM, 0);

// Specify the address and port of the socket
addr.sin_family = AF_INET;
addr.sin_port = htons(80);
addr.sin_addr.s_addr = htonl(INADDR_ANY);

// Bind the socket to the address and port
bind(sockfd, (struct sockaddr *) &addr, sizeof(addr));
```
This code creates a new socket using the `socket()` function, with the AF_INET address family (IPv4) and the SOCK_STREAM socket type (TCP). Then it specifies the address and port of the socket using a `struct sockaddr_in` structure, which is a specific version of the `struct sockaddr` for IPv4 addresses. The `sin_family` field is set to AF_INET, the `sin_port` field is set to the port number (80) in network byte order, and the `sin_addr` field is set to INADDR_ANY, which binds the socket to all available network interfaces on the host. Finally, the socket is bound to the specified address and port using the `bind()` function.

It's important to note that, `struct sockaddr` is a generic structure, it does not provide any fields for specific address information, such as IP address and port number. It's also used with `struct sockaddr_in`, `struct sockaddr_in6` for IPv4 and IPv6 respectively.