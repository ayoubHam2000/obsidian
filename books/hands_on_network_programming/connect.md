The `connect()` function is a function provided by the C standard library that is used to initiate a connection to a remote host on a specified port. It is typically used with sockets of type `SOCK_STREAM` (TCP) to establish a reliable, two-way, stream-oriented connection.

The `connect()` function takes the following arguments:
```C
int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
```
If the socket _sockfd_ is of type **SOCK_DGRAM**, then _addr_ is the
       address to which datagrams are sent by default, and the only
       address from which datagrams are received.  If the socket is of
       type **SOCK_STREAM** or **SOCK_SEQPACKET**, this call attempts to make a
       connection to the socket that is bound to the address specified
       by _addr_.
      
- `sockfd` is the socket descriptor returned by the `socket()` function.
-   `addr` is a pointer to a `struct sockaddr` object that contains the address of the remote host. It typically points to a `struct sockaddr_in` (IPv4) or `struct sockaddr_in6` (IPv6) structure.
-   `addrlen` is the size of the `struct sockaddr` object, usually `sizeof(struct sockaddr_in)` or `sizeof(struct sockaddr_in6)`.

The `connect()` function returns 0 on success, otherwise, it returns -1 and sets the `errno` variable to indicate the error.

Here is an example of how to use the `connect()` function to establish a TCP connection with a remote host:
```C
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    int sockfd;
    struct sockaddr_in serv_addr;

    if (argc != 3) {
        fprintf(stderr,"usage: %s hostname port\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    // set the address of the server
    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    inet_pton(AF_INET, argv[1], &serv_addr.sin_addr);
    serv_addr.sin_port = htons(atoi(argv[2]));

    // connect to the server
    if (connect(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0) {
        perror("connect failed");
        exit(EXIT_FAILURE);
    }

    // communicate with the server
    // ...

    // close the socket
    close(sockfd);
    return 0;
}
```
This example first creates a socket using the `socket()` function, then it sets the address of the server using the `struct sockaddr_in` structure, and the `inet_pton()` function to convert the IP address from a string to a binary representation. It then uses the `connect()` function to initiate a connection to the server, passing the socket descriptor, the address of the server, and the size of the address as arguments. If the function returns -1, it means that an error has occurred, In which case `perror()` function is used to print a message describing the error, and the program exits with a failure status. If the connection is successful, the program can communicate with the server using the `sockfd` file descriptor. At the end of the communication, the socket should be closed using the `close()` function.