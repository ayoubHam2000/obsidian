* `AI_PASSIVE` can be used with node = 0 to request the wildcard address. This is the local address that accepts connections on any of the host's network addresses. It is used on servers with bind(). If node is not 0, then AI_PASSIVE has no effect.
*  `AI_NUMERICHOST` can be used to prevent name lookups. In this case, getaddrinfo() would expect node to be an address such as 127.0.0.1 and not a hostname such as example.com. AI_NUMERICHOST can be useful because it prevents getaddrinfo() from doing a DNS record lookup, which can be slow.
* `AI_NUMERICSERV` can be used to only accept port numbers for the service argument. If used, this flag causes getaddrinof() to reject service names.
-   `AI_PASSIVE`: used to indicate that the returned address should be used for bind() to specify the socket's local address.
-   `AI_CANONNAME`: requests the function to return the canonical name for the host in the `ai_canonname` field.
-   `AI_V4MAPPED`: requests that IPv4-mapped IPv6 addresses be returned when no IPv6 addresses are found.
- `AI_ALL`: The value of "AI_ALL" is a bitwise OR of multiple flags that request that both IPv4 and IPv6 addresses be returned.