`getnameinfo()` is a function provided by the C standard library that is used to convert socket addresses to host names and service names. It is the counterpart of the `getaddrinfo()` function, which converts host names and service names to socket addresses.

The `getnameinfo()` function takes the following arguments:
```C
int getnameinfo(const struct sockaddr *sa, socklen_t salen, char *host, size_t hostlen, char *serv, size_t servlen, int flags);
```
-   `sa` is a pointer to a socket address, usually a `struct sockaddr_in` (IPv4) or `struct sockaddr_in6` (IPv6)
-   `salen` is the length of the socket address, usually `sizeof(struct sockaddr_in)` or `sizeof(struct sockaddr_in6)`
-   `host` is a buffer that will be filled with the host name associated with the socket address
-   `hostlen` is the size of the `host` buffer
-   `serv` is a buffer that will be filled with the service name or port number associated with the socket address
-   `servlen` is the size of the `serv` buffer
-   `flags` is a bit-mask that can be used to modify the behavior of the function

The `getnameinfo()` function returns a 0 if the host name and service name are successfully obtained, otherwise, returns a non-zero value which should be passed to `gai_strerror()` function to get the corresponding error message.

The `host` and `serv` arguments are pointers to buffers that will be filled with the host name and service name or port number, respectively. The length of the buffers is specified by the `hostlen` and `servlen` arguments. If the host name or service name is not available, the buffers will be filled with the numeric IP address or port number, respectively.

The `flags` argument can be used to specify the format of the service name. The NI_NUMERICSERV flag can be used to request that the service name be returned as a numeric string (i.e., a port number) instead of a service name.

Here is an example of how to use the `getnameinfo()` function to obtain the host name and service name of a socket address:
```C
#include <arpa/inet.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>

int main() {
    struct sockaddr_in addr;
    char host[NI_MAXHOST], service[NI_MAXSERV];
    int status;

    // set the address
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    inet_pton(AF_INET, "127.0.0.1", &addr.sin_addr);
    addr.sin_port = htons(80);

    status = getnameinfo((struct sockaddr *) &addr, sizeof(addr), host, sizeof(host), service, sizeof(service), NI_NUMERICSERV);
    if (status != 0) {
        fprintf(stderr, "getnameinfo: %s\n", gai_strerror(status));
        return 1;
    }

    printf("host: %s\n", host);
    printf("service: %s\n", service);

    return 0;
}
```
This example first creates a socket address using the `struct sockaddr_in` structure. It sets the address family, IP address and port number, then it uses the getnameinfo() function to retrieve the hostname and service name corresponding to this address. It uses the `inet_pton()` function to convert the IP address from a string to a binary representation. The `NI_NUMERICSERV` flag tells getnameinfo to return the service name as a numerical port number. It then prints out the retrieved hostname and service name.