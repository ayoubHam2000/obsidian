`struct addrinfo` is a data structure defined in the C standard library's networking headers (such as `<netdb.h>`) that contains information about an Internet address. It is used in C network programming to represent address information returned by the `getaddrinfo()` function.

The `struct addrinfo` includes the following fields:
```C
struct addrinfo {
	int ai_flags; // Flags for the getaddrinfo() function 
	int ai_family; // Protocol family for the address 
	int ai_socktype; // Socket type for the address 
	int ai_protocol; // Protocol for the address 
	socklen_t ai_addrlen; // Length of the socket address 
	struct sockaddr *ai_addr; // Pointer to the socket address 
	char *ai_canonname; // Canonical name for the address 
	struct addrinfo *ai_next; // Pointer to the next addrinfo in the list 
};
```

`ai_flags` field can contain different flags that modify the behavior of the `getaddrinfo()` function. see [[addrinfo_flags]]

`ai_family` field defines the protocol family of the address, such as `AF_INET` for IPv4 or `AF_INET6` for IPv6. or AF_UNSPEC for any address family. AF_UNSPEC is defined as 0.

`ai_socktype` field defines the socket type, such as `SOCK_STREAM` for TCP or `SOCK_DGRAM` for UDP. Setting ai_socktype to 0 indicates that the address could be used for either.

`ai_protocol` field defines the protocol to use, such as `IPPROTO_TCP` for TCP or `IPPROTO_UDP` for UDP. ai_protocol should be left to 0. Strictly speaking, TCP isn't the only streaming protocol supported by the socket interface, and UDP isn't the only datagram protocol supported. ai_protocol is used to disambiguate, but it's not needed for our purposes.

`ai_addrlen` field is the length of the socket address stored in `ai_addr`

`ai_addr` field is pointer to a `struct sockaddr`, and it contains the socket address.

`ai_canonname` field contains the canonical name for the address, if one is available.

`ai_next` field is a pointer to the next `addrinfo` structure in a linked list of `addrinfo` structures.

The `getaddrinfo()` function is used to get a list of `addrinfo` structures, each of which corresponds to a socket address that can be used to connect to a service. The function takes a host name or IP address and a service name or port number as input, and returns a linked list of `addrinfo` structures that contain information about the available socket addresses.

Here is an example of using the `getaddrinfo()` function to get a list of `addrinfo` structures for a given host and service:

```C
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>

int main(int argc, char *argv[]) {
    struct addrinfo hints, *res, *p;
    int status;

    if (argc != 3) {
        fprintf(stderr,"usage: example hostname port\n");
        return 1;
    }

    // Set up hints for the getaddrinfo function
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;  // Can be either IPv4 or IPv6
    hints.ai_socktype = SOCK_STREAM; // Using TCP
    hints.ai_flags = AI_PASSIVE; // Use wildcard IP address

    // Get the list of addrinfo structs
    status = getaddrinfo(argv[1], argv[2], &hints, &res);
    if (status != 0) {
        fprintf(stderr, "getaddrinfo error: %s\n", gai_strerror(status));
        return 2;
    }

    // Iterate through the addrinfo list
    for (p = res; p != NULL; p = p->ai_next) {
        // Try to create a socket and connect to the address
        int sockfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol);
        if (sockfd == -1) {
            continue; // if we couldn't create socket, try the next addrinfo
        }
        if (connect(sockfd, p->ai_addr, p->ai_addrlen) != -1) {
            printf("Connected to %s on port %s\n", argv[1], argv[2]);
            break;  // Stop iterating if the connect is successful
        }
        close(sockfd); // Close the socket if the connection failed
    }
    freeaddrinfo(res); // free the linked list
    if (p == NULL) {
        fprintf(stderr, "Failed to connect to %s on port %s\n", argv[1], argv[2]);
        return 3;
    }

    return 0;
}

```

The example uses the `getaddrinfo()` function to obtain a linked list of `addrinfo` structures that match the given host name and service name or port number. It sets up a hint structure with the hints for the getaddrinfo function, and passes it to the `getaddrinfo()` function along with the host name, service name or port number and then It iterates through the returned linked list of `addrinfo` structures, creates a socket and tries to connect to each address. The loop stops when it successfully connects to an address. Please note that The example assumes that the command line arguments are the hostname and port.