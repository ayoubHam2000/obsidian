  apt install vsftpd -y
vsftpd.userlist
vsftpd.conf

---

-   `listen=YES`: This line sets the server to listen for incoming connections.
-   `listen_port=21`: This line sets the port number to listen on. FTP servers typically use port 21 for incoming connections.
-   `listen_address=0.0.0.0`: This line sets the IP address to listen on. The IP address 0.0.0.0 means that the server should listen on all available network interfaces.
-   `seccomp_sandbox=NO`: This line sets whether or not to use a seccomp sandbox. Seccomp is a Linux kernel feature that can be used to restrict the system calls that a process can make, in order to improve security. Setting this to "NO" means that the server is not using a seccomp sandbox.
- `anonymous_enable=YES`: This line enables the anonymous FTP login feature on the server. When set to "YES", users can log in as "anonymous" and may be able to access certain files or directories that have been made publicly available. This feature can be useful for sharing files with a large number of users, but it can also pose security risks if not configured properly.
-  `local_enable=YES`: This line enables local FTP login, meaning that users can connect to the server using a username and password that are registered on the server itself (as opposed to logging in anonymously). When set to "YES", users can log in using their own credentials and may be able to access files or directories that they have permission to access. This is typically the default setting for FTP servers.
-   `write_enable=YES`: This line enables write access to the FTP server, meaning that users who are logged in can upload or modify files on the server (depending on their permissions). When set to "YES", users can transfer files to and from the server, as well as create, delete, or modify files and directories. This can be useful for allowing users to update a website or collaborate on shared files, but it can also pose security risks if not configured properly.


----
-   `chroot_local_user=YES`: This line specifies that local users will be "chrooted", which means that they will be confined to a specific directory on the server and will not be able to navigate outside of it. This is a security feature that can help prevent users from accessing or modifying files that they should not have access to.
    
-   `allow_writeable_chroot=YES`: This line allows users who are chrooted to have write access to their own directory, even if it is not normally writable. This can be useful for allowing users to upload files or make modifications to their own website or files.
    
-   `user_sub_token=$USER`: This line sets a token that will be replaced with the username of the current user in certain configuration settings. This can be useful for creating configuration files that are specific to individual users.
    
-   `local_root=/var/www/aben-ham.42.fr/html`: This line sets the local root directory for the FTP server, which is the directory that users will be confined to if `chroot_local_user` is set to "YES". In this case, the root directory is set to `/var/www/aben-ham.42.fr/html`, which means that users will only be able to access files within that directory and its subdirectories.


---
-   `pasv_enable=YES`: This line enables passive mode for the FTP server. In passive mode, the server opens a data port and waits for the client to connect to it, rather than the other way around. This can be useful for clients that are behind firewalls or NAT devices that might otherwise block incoming connections.
    
-   `pasv_min_port=21100`: This line sets the minimum port number that can be used for passive mode data connections. In this case, the minimum port number is set to 21100.
    
-   `pasv_max_port=21110`: This line sets the maximum port number that can be used for passive mode data connections. In this case, the maximum port number is set to 21110.
---
-   `userlist_enable=YES`: This line enables the use of a userlist file to control access to the FTP server. When this setting is enabled, only users listed in the userlist file will be allowed to connect to the server.
    
-   `userlist_file=/etc/vsftpd.userlist`: This line specifies the location of the userlist file. In this case, the file is located at `/etc/vsftpd.userlist`.
    
-   `userlist_deny=NO`: This line specifies whether users who are listed in the userlist file should be denied access to the server. When set to "NO", users who are listed in the userlist file will be allowed to connect to the server.
---
-   `dirmessage_enable=YES`: This line enables the display of a message when a user connects to the server and changes to a new directory. This message can be used to provide information or instructions to users.
    
-   `use_localtime=YES`: This line specifies that the server should use the local system time for logging and displaying file timestamps. This can be useful for ensuring consistency between different systems that may be located in different time zones.
    
-   `xferlog_enable=YES`: This line enables the logging of file transfers and other FTP activity to a log file. This can be useful for monitoring server activity and troubleshooting issues.
    
-   `connect_from_port_20=YES`: This line specifies that the server should use port 20 for outgoing data connections. In FTP, port 20 is traditionally used for sending data from the server to the client, while port 21 is used for control traffic.
---
`/var/run/vsftpd/empty` is a file path that is often used in the configuration of an FTP (File Transfer Protocol) server to prevent anonymous users from uploading files.

The `empty` file is a 0-byte file that is used to create a writable directory for anonymous users without allowing them to actually upload any files. When an anonymous user attempts to upload a file to the server, the upload will fail because the `empty` file cannot be overwritten.

By creating a writable directory without allowing uploads, the server can provide anonymous access to certain files or directories without risking the upload of malicious content.
Also, the directory should not be writable by the ftp user.