## Rule the can be handle by a http server

An HTTP server is a complicated program. It must 
- handle multiple simultaneous connections
- parse a complex text-based protocol
- handle malformed requests with the proper errors
- and serve files.
- telling the client the content type of each resource it sends.
- One of the most important rules, when developing networked code, is that your program should never trust the connected peer.

## MIME (Multipurpose Internet Mail Extensions)

A MIME (Multipurpose Internet Mail Extensions) type is a string identifier that specifies the format of a file. It is used in HTTP to indicate the type of data being sent in a request or response. The MIME type is specified in the Content-Type header of an HTTP message.
The most common values for MIME types are:
1.  "text/plain" for plain text files
2.  "text/html" for HTML files
3.  "application/json" for JSON data
4.  "application/xml" for XML data
5.  "image/jpeg" for JPEG images
6.  "image/png" for PNG images
7.  "image/gif" for GIF images
8.  "audio/mpeg" for MP3 audio files
9.  "video/mp4" for MP4 video files
10.  "application/pdf" for PDF documents
11. "application/zip" for ZIP archives
12. .css text/css
13. .csv text/csv
14. .htm text/html
15. .ico image/x-icon
16. .js application/javascript
17. .svg image/svg+xml
18. "application/msword" for Microsoft Word documents

	unknown media type ?

If a file's media type is unknown, then our server should use application/octet- stream as a default. This indicates that the browser should treat the content as an unknown binary blob.

	determinate the MIME type

If you're on a Unix-based system, such as Linux or macOS, then your operating system already provides a utility for this.
```bash
file --mime-type example.txt
```

## Notes

- if the path is /, then we need to serve a default file.
- If we allowed paths with .., then a malicious client could send GET /../web_server.c HTTP/1.1 and gain access to our server source code!
- It is important to note that the directory separator differs between Windows and other operating systems. While Unix-based systems use a slash (/), Windows instead uses a backslash (\) as its standard. Many Windows functions handle the conversion automatically, but the difference is sometimes important.
- If `fopen()` succeeds, then we can use `fseek()` and `ftell()` to determine the requested file's size.
- Once the file has been located and we have its length and type, the server can begin sending the HTTP response.
- The server can now send the actual file content. This is done by calling `fread()` repeatedly until the entire file is sent

---
1. Keep in mind that while serve_resource() attempts to limit access to only the public directory, it is not adequate in doing so, and serve_resource() should not be used in production code without carefully considering additional access loopholes. We discuss more security concerns later in this chapter.
2. Note that `send()` may block on large files. In a truly robust, production-ready server, you would need to handle this case. It could be done by using` select()` to determine when each socket is ready to read. Another common method is to use `fork()` or similar APIs to create separate `threads/processes` for each connected client.
3. If a network client can cause your code to write past the end of a buffer, then that client may be able to completely compromise your server. This is because both data and executable code are stored in your server's memory. A malicious client may be able to write executable code past the buffer array and cause your program to execute it. Even if the malicious code isn't executed, the client could still overwrite other important data in your server's memory.
4. Please understand that these are not purely theoretical concerns, but actual exploitable bugs. For example, if you run our web_server.c program on Windows and a client sends the request GET /this_will_be_funny/PRN HTTP/1.1, what do you suppose happens?
	The this_will_be_funny directory doesn't exist, and the PRN file certainly doesn't exist in that non-existent directory. These facts may lead you to think that the server simply returns a 404 Not Found error, as expected. However, that's not what happens. Under Windows, PRN is a special filename. When your server calls fopen() on this special name, Windows doesn't look for a file, but rather it connects to a printer interface! Other special names include COM1 (connects to serial port 1) and LPT1 (connects to parallel port 1), although there are others. Even if these filenames have an extension, such as PRN.txt, Windows still redirects instead of looking for a file.
5. In other words, if you are going to run a networked server, create a new account to run it under. Give that account read access to only the files that server needs to serve. This is not a substitute for writing secure code, but rather running as a non-privilege user creates one final barrier. It is advice you should apply even when running hardened, industry-tested server software.
---
- CGI
- Proxy, reverse proxy, ch8 SMTP