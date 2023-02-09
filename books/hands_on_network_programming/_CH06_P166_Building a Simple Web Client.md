
## HTTP request types

`GET` is used when the client wants to download a resource.

`HEAD` is just like GET, except that the client only wants information about the resource instead of the resource itself. For example, if the client only wants to know the size of a hosted file, it could send a HEAD request. if the client had sent a HEAD request type instead of GET, then the server would respond with exactly the same HTTP headers as before, but it would not include the HTTP body.

`POST`is used when the client needs to send information to the server. Your web browser typically uses a POST request when you submit an online form, for example. A POST request will typically cause a web server to change its state somehow. A web server could send an email, update a database, or change a file in response to a POST request.

---
`PUT` is used to send a document to the web server. PUT is not commonly used. POST is almost universally used to change the web server state.
`DELETE` is used to request that the web server should delete a document or resource. Again, in practice, DELETE is rarely used. POST is commonly used to communicate web server updates of all types.  
`TRACE` is used to request diagnostic information from web proxies. Most web requests don't go through a proxy, and many web proxies don't fully support TRACE. Therefore, it's rare to need to use TRACE.
`CONNECT` is sometimes used to initiate an HTTP connection through a proxy server.  
`OPTIONS` is used to ask which HTTP request types are supported by the server for a given resource. A typical web server that implements OPTIONS may respond with something similar to Allow: OPTIONS, GET, HEAD, POST. Many common web servers don't support OPTIONS.

## HTTP request format

![[Screen Shot 2023-02-08 at 1.27.29 PM.png]]

* A `GET` request consists of `HTTP` headers only. There is no` HTTP` body because the client isn't sending data to the server. The client is only requesting data from the server. In contrast, a `POST` request would contain an `HTTP` body.

* The first line of an `HTTP` request is called the `request line`. The request line consists of three parts – the `request type`, the `document path`, and the `protocol version`. Each part is separated by a *space*.
* After the request line, there are various HTTP header fields. Each header field consists of its name followed by a colon, and then its value.
* `The only header field that is actually required is Host.` The `Host` field tells the web server which web host the client is requesting the resource from. This is important because one web server may be hosting many different websites
* The `Connection: Keep-Alive` line tells the web server that the HTTP client would like to issue additional requests after the current request finishes. If the client had sent `Connection: Close` instead, that would indicate that the client intended to close the TCP connection after the HTTP response was received.
* When dealing with text-based network protocols, it is always important to be *explicit about line endings*. This is because different operating systems have standardized on different line-ending conventions. *Each line of an HTTP message ends with a carriage return, followed by a newline character. In C, this looks like \\r\\n.*
* The web client must send a `blank line after the HTTP request header`. This blank line is how the web server knows that the HTTP request is finished. (\\r\\n\\r\\n)

## HTTP response format

```bash
   HTTP/1.1 200 OK
   Cache-Control: max-age=604800
   Content-Type: text/html; charset=UTF-8
   Date: Fri, 14 Dec 2018 16:46:09 GMT
   Etag: "1541025663+gzip"
   Expires: Fri, 21 Dec 2018 16:46:09 GMT
   Last-Modified: Fri, 09 Aug 2013 23:54:35 GMT
   Server: ECS (ord/5730)
   Vary: Accept-Encoding
   X-Cache: HIT
   Content-Length: 1270

   <!doctype html>
   <html>
   <head>
    <title>Example Domain</title>
   ...
```
* The first line of an HTTP response is `the status line`. The status line consists of the `protocol version`, the `response code`, and the `response code description`.
* Many of the HTTP response headers are used to assist with `caching`. `The Date`, `Etag`, `Expires`, and `Last-Modified` fields can all be used by the client to cache documents.
* The `Content-Type` field tells the client what type of resource it is sending. In the preceding example, it is an HTML web page, which is specified with `text/html`. HTTP can be used to send all types of resources, **such as images, software, and videos**. Each resource type has a specific Content-Type, which tells the client how to interpret the resource.
* The `Content-Length` field specifies the size of the HTTP response body in bytes. In this case, we see that the requested resource is 1270 bytes long. **There are a few ways to determine the body length, but the Content-Length field is the simplest.**
* Note that the HTTP body is not necessarily text-based. For example, if the client requested an image, then the HTTP body would likely be binary data. Also consider that, if the HTTP body is text-based, such as an HTML web page, it is free to use its own line-ending convention.
* If the server would like to begin sending data before the body's length is known, then it can't use the `Content-Length` header line. In this case, the server can send a `Transfer- Encoding: chunked` header line. This header line indicates to the client that the response body will be sent in separate chunks. **Each chunk begins with its chunk length, encoded in base-16 (hexadecimal), followed by a newline, and then the chunk data. The entire HTTP body ends with a zero-length chunk.**
```c
   HTTP/1.1 200 OK
   Content-Type: text/plain; charset=ascii
   Transfer-Encoding: chunked

   44
   Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eius
   37
   mod tempor incididunt ut labore et dolore magna aliqua.
   0
```
- Now that the headers have been received, we need to determine whether the HTTP server is using Content-Length or Transfer-Encoding: chunked to indicate body length. If it doesn't send either, then we assume that the entire HTTP body has been received once the connection is closed.


## HTTP response codes

* If the request was successful, then the server responds with a code in the `200 range`:
`200 OK`: The client's request is successful, and the server sends the requested resource

* If the resource has moved, the server can respond with a code in the `300 range.` These codes are commonly used to redirect traffic from an unencrypted connection to an encrypted one, or to redirect traffic from a www subdomain to a bare one.
`301 Moved Permanently`: The requested resource has moved to a new location. This location is indicated by the server in the Location header field. All future requests for this resource should use this new location.  
`307 Moved Temporarily`: The requested resource has moved to a new location. This location is indicated by the server in the Location header field. This move may not be permanent, so future requests should still use the original location.

* Errors are indicated by `400 or 500 range` response codes. Some common ones are as follows:
`400 Bad Request`: The server doesn't understand/support the client's request
`401 Unauthorized`: The client isn't authorized for the requested resource
`403 Forbidden`: The client is forbidden to access the requested resource
`500 Internal Server Error`: The server encountered an error while trying to fulfill the client's 
request


-   200 OK: The request was successful and the server has returned the requested data.
-   201 Created: The request was successful and the server has created a new resource as a result.
-   204 No Content: The request was successful, but there is no representation to return (i.e., the response is empty).
 -   302 Found (Previously "Moved temporarily"): The requested resource has been temporarily moved to a different URI.
-   304 Not Modified: The client's cached version of the resource is up-to-date, so the server does not need to send a new copy.
-   307 Temporary Redirect: The requested resource has been temporarily moved to a different URI.
-   400 Bad Request: The request could not be understood or was missing required parameters.
-   401 Unauthorized: The client failed to provide valid authentication credentials.
-   403 Forbidden: The client does not have access to the requested resource.
-   404 Not Found: The requested resource could not be found on the server.
-   405 Method Not Allowed: The request method is not supported by the target resource.
-   429 Too Many Requests: The user has sent too many requests in a given amount of time.
-   410 Gone: The requested resource is no longer available and will not be available again.
-   500 Internal Server Error: An error occurred on the server.
-   503 Service Unavailable: The server is temporarily unable to handle the request.


## URL

`Uniform Resource Locators (URL)`, also known as web addresses, provide a convenient way to specify particular web resources.

![[Screen Shot 2023-02-08 at 2.51.57 PM.png]]

- The URL can indicate the protocol, the host, the port number, the document path, and hash. However, the host is the only required part. The other parts can be implied.
* ... hostname: .... This part can also be an IP address instead of a name. IPv4 addresses are used directly `(http://192.168.50.1/)`, but IPv6 addresses should be put inside square brackets ``(http://[::1]/)`.
* `#account`: This is called the `hash`. The hash specifies a position within a document, and the hash is not sent to the HTTP server. It instead allows a browser to scroll to a particular part of a document after the entire document is received from the HTTP server.

## HTTP POST requests

![[Screen Shot 2023-02-08 at 4.22.52 PM.png]]
`Encoding form data`
![[Screen Shot 2023-02-08 at 4.23.07 PM.png]]
`File uploads`
![[Screen Shot 2023-02-08 at 4.23.20 PM.png]]
## Notes

* HTTP (HyperText Transfer Protocol) is a widely-used application-layer protocol for transmitting hypermedia information, such as HTML pages, over the internet. It operates on top of other lower-level protocols, such as TCP (Transmission Control Protocol).

* TCP, on the other hand, is a transport-layer protocol that provides reliable, ordered, and error-checked delivery of data between applications running on different hosts. It is one of the main protocols in the Internet protocol suite (also known as TCP/IP).

* In other words, HTTP is a protocol used to transfer information in the form of web pages, while TCP is a protocol used to ensure the reliable delivery of data between applications. HTTP relies on TCP as the underlying transport protocol to provide reliable data transmission.

* HTTPS secures HTTP by merely running the HTTP protocol through a Transport Layer Security (TLS) layer. Therefore, everything we cover in this chapter regarding HTTP also applies to HTTPS.
---

* If you send a request that the web server doesn't support, then the server should respond with a 400 Bad Request code.

	multiple hostnames can resolve to the same IP address ?

Yes, that's correct. Multiple hostnames can resolve to the same IP address using a technique called round-robin DNS. In this technique, multiple hostnames are associated with a single IP address, and the DNS server returns a different hostname each time a client requests the IP address, rotating through the list of hostnames.

This can be useful for distributing the load across multiple servers, allowing a single IP address to represent multiple servers and allowing each server to handle a portion of the incoming traffic. Round-robin DNS is often used in combination with other load balancing techniques, such as hardware load balancers, to distribute traffic more efficiently and improve the performance and reliability of a network.