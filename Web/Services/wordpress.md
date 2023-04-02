## Connect wordpress with redis remotly

- Configure Redis on the remote server. You will need to set up a Redis server on the remote machine and configure it to accept remote connections.

```js
	apt install redis-server -y
	
	//run redis
	redis-server //`--protected-mode no`
	//monitoring
	redis-cli monitor
```
path for redis configuration `/etc/redis/redis.conf`

> Connection Exception: `SELECT` failed: DENIED Redis is running in protected mode because protected mode is enabled, no bind address was specified, no authentication password is requested to clients. In this mode connections are only accepted from the loopback interface. If you want to connect from external computers to Redis you may adopt one of the following solutions: 1) Just disable protected mode sending the command 'CONFIG SET protected-mode no' from the loopback interface by connecting to Redis from the same host the server is running, however MAKE SURE Redis is not publicly accessible from internet if you do so. Use CONFIG REWRITE to make this change permanent. 2) Alternatively you can just disable the protected mode by editing the Redis configuration file, and setting the protected mode option to 'no', and then restarting the server. 3) If you started the server manually just for testing, restart it with the `--protected-mode no` option. 4) Setup a bind address or an authentication password. NOTE: You only need to do one of the above things in order for the server to start accepting connections from the outside. [tcp://redis:6379] (Predis\Connection\ConnectionException)

- connect WordPress with Redis remotely
1.  Install the Redis Object Cache plugin on your WordPress site using WP-CLI. You can do this by running the following command:

```js
wp plugin install redis-cache --activate
```

2. Add the configuration to `wp-config.php` using WP-CLI. You can use the following command to add the configuration to `wp-config.php`

```js
wp config set WP_REDIS_HOST your-remote-redis-hostname-or-ip-address --type=constant
wp config set WP_REDIS_PORT your-remote-redis-port --type=constant
wp redis enable
```

3.  Restart your web server.