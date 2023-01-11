The `bind()` function is a function provided by the C standard library that is used to associate a socket with a local address and port. It is typically used with sockets of type `SOCK_STREAM` (TCP) or `SOCK_DGRAM` (UDP) to specify the local address and port on which the socket should listen for incoming connections or incoming data.

The `bind()` function takes the following arguments:
```C
int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
```
-   `sockfd` is the socket descriptor returned by the `socket()` function.
-   `addr` is a pointer to a `struct sockaddr` object that contains the address and port that the socket should be bound to. It typically points to a `struct sockaddr_in` (IPv4) or `struct sockaddr_in6` (IPv6) structure.
-   `addrlen` is the size of the `struct sockaddr` object, usually `sizeof(struct sockaddr_in)` or `sizeof(struct sockaddr_in6)`.

The `bind()` function returns 0 on success, otherwise, it returns -1 and sets the `errno` variable to indicate the error.

Here is an example of how to use the `bind()` function to associate a socket with a local address and port:
```C
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    int sockfd;
    struct sockaddr_in addr;

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    // set the address and port of the socket
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_ANY);
    addr.sin_port = htons(80);

    // bind the socket to the address and port
    if (bind(sockfd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }

    // listen for incoming connections
    if (listen(sockfd, 5) < 0) {
        perror("listen failed");
        exit(EXIT_FAILURE);
    }

    // accept incoming connections
    // ...

    // close the socket
    close(sockfd);
    return 0;
}
```
This example first creates a socket using the `socket()` function, then it sets the address and port of the socket using the `struct sockaddr_in` structure, the `htons()` function is used to convert the port number to network byte order. Then the `bind()` function is called passing the socket descriptor, the address and port of the socket, and the size of the address as arguments to associate the socket with that address and port. If the function returns -1, it means that an error has occurred, in which case `perror()` function is used to print a message describing the error, and the program exits with a failure status. Once the socket is bound to a specific address and port, you can start listening for incoming connections by calling the `listen()` function