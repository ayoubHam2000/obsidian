```C
while(1)
{
	socket_client = accept(socket_listen, &new_client, &new_client_length);
	int pid = fork();
	if (pid == 0) { //child process
	
	   close(socket_listen);
	   recv(socket_client, ...);
	   send(socket_client, ...);
	   close(socket_client);
	   exit(0);
	
	}
	//parent process
	close(socket_client);
}
```