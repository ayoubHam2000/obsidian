
### How to Set Up SSH Passwordless Login

https://www.strongdm.com/blog/ssh-passwordless-login

- Use _ssh-keygen_ to generate a key pair consisting of a public key and a private key on the client computer.
	`ssh-keygen -t rsa
- On Server side
```
mkdir .ssh
#copy the public key from client side to server side
scp .ssh/id_rsa.pub user@somedomain:~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```
- On Client side
```
ssh-add ~/.ssh/id_rsa
```