
## Create Service

```
sudo nano /etc/systemd/system/myservice.service
```

### Basic service example

```

[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/myservice.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```

```
Reload systemd to recognize the service
sudo systemctl daemon-reload

Enable the service at boot
sudo systemctl enable myservice.service

Start and test the service now
sudo systemctl start myservice.service

Check status:
sudo systemctl status myservice.service
```

## Create a user

```
sudo adduser username

```

> To give the user **sudo** privileges

```
sudo usermod -aG sudo user
**log out and log back**

----
(/etc/sudoers)
sudo visudo
username ALL=(ALL:ALL) ALL
```

> Change user and group owner

```
sudo chown user:groupname filename
recursively
sudo chown -R :developers /var/www
```

> Change permissions

```
chmod u+r
chmod g+r
chmod o+r
chmod o-r
chmod g-r
chmod u-r
chmod +r
chmod -r
chmod 777 means 111-111-111 (rwx-rwx-rwx)
chmod u=rwx,g=rx,o= filename
recursively
chmod -R
```

> Open a shell as a user

```
sudo -u www-data /bin/bash
```

## Zip

```
unzip
```

## Install certbot



## systemctl

```
List all services (active, inactive, loaded, etc.)
systemctl list-unit-files --type=service

List only running (active) services
systemctl --type=service --state=running

List all systemd services with status info
systemctl list-units --type=service

Check status of a specific service
systemctl status servicename
```

## Install nextcloud with nginix and postgresql

https://nextcloud.com/install/#download-server

```
wget https://download.nextcloud.com/server/releases/latest.zip
```

```
Install PostgreSQL
sudo apt install postgresql -y
```


```sql
sudo -u postgres psql
CREATE DATABASE nextcloud TEMPLATE template0 ENCODING 'UTF8';
CREATE USER ncuser WITH PASSWORD 'StrongPasswordHere';
GRANT ALL PRIVILEGES ON DATABASE nextcloud TO ncuser;

\c nextcloud
GRANT ALL PRIVILEGES ON SCHEMA public TO ncuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO ncuser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ncuser;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO ncuser;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO ncuser;

see errors
sudo -u postgres psql -c "\l"
```


### Install PHP-FPM + common PHP modules

```
sudo apt update
sudo apt install php-fpm php-cli php-common php-opcache php-zip php-gd php-curl php-mbstring php-intl php-bcmath php-gmp php-xml php-imagick php-apcu -y

-> Install PostgreSQL PHP driver

sudo apt install php-pgsql -y
sudo systemctl restart php[version]-fpm  (systemctl --type=service --state=running)
```

### Configure Nginx to use PHP-FPM

```
sudo nano /etc/nginx/sites-available/nextcloud.conf

server {
    listen 3001;
    server_name foxer19.hopto.org;

    root /var/www/next-cloud/nextcloud;
    client_max_body_size 2048M;

    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header Referrer-Policy "no-referrer";

    index index.php;

    # Protect data folder
    location ~ ^/data/ {
        deny all;
        return 403;
    }

    location / {
        try_files $uri $uri/ /index.php$request_uri;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;

        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;

        fastcgi_pass unix:/run/php/php-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}

sudo ln -s /etc/nginx/sites-available/nextcloud.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

```
Make sure your data folder is outside the web root
If your data folder is inside `/var/www/nextcloud`, it _can_ be safe if Nginx blocks access — but the **recommended** method is to move it _outside_ the web folder.

sudo -u www-data mv /var/www/nextcloud/data /var/nextcloud-data
sudo nano /var/www/nextcloud/config/config.php
'datadirectory' => '/var/nextcloud-data',
sudo systemctl reload nginx
sudo systemctl restart php*-fpm
```

### Complete the setup in browser

```
- Admin username & password
    
- Database name: **nextcloud**
    
- Database user: **ncuser**
    
- Database pass: _(your password)_
    
- Database host: **localhost**
```




```
server {
    listen 80;
    server_name foxer19.hopto.org

    root /var/www/next-cloud/nextcloud;
    index index.php;

    client_max_body_size 2048M;

    # Prevent access to the data folder
    location ~ ^/data/ {
        deny all;
        return 403;
    }

    # MAIN routing
    location / {
        try_files $uri $uri/ /index.php$request_uri;
    }

    # STOP rewrite loops for static files
    location = /favicon.ico {
        try_files $uri $uri/ /apps/theming/favicon.ico;
        access_log off;
        log_not_found off;
    }

    location = /robots.txt {
        try_files $uri $uri/ /robots.txt;
        access_log off;
        log_not_found off;
    }

    # Allow static files to pass straight through (NO rewrites)
    location ~* \.(?:css|js|woff2?|svg|gif|map|png|jpg|ico)$ {
        try_files $uri /index.php$request_uri;
        access_log off;
        log_not_found off;
    }

    # PHP handling
    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;

        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;

        fastcgi_pass unix:/run/php/php-fpm.sock;   # ← adjust if using php8.1/8.2
        fastcgi_intercept_errors on;
        fastcgi_request_buffering off;
    }

    # Block dangerous files
    location ~ /\.well-known/(?!acme-challenge) {
        deny all;
    }

    location ~ /\.ht {
        deny all;
    }
}

```

## VPN

```
sudo apt update && sudo apt upgrade -y

sudo apt install wireguard -y

```

#### Turn on IP forwarding on Linux
```
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1
```

```
wg-quick up wg0
wg
```

```
cd /etc/wireguard/wg0.conf
nano /etc/wireguard/wg0.conf
wg genkey | tee server_private.key | wg pubkey > server_public.key
```

```
[Interface]
Address = 192.168.100.127/24
ListenPort = 52820
PrivateKey = SERVER_PRIVATE_KEY

PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

```


```sh
#!/bin/bash
IPT="/sbin/iptables"
# IPT6="/sbin/ip6tables"          
 
IN_FACE="enp2s0"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC 
SUB_NET="192.168.100.10/24"            # WG IPv4 sub/net aka CIDR
WG_PORT="51194"                  # WG udp port

# SUB_NET_6="fd42:42:42:42::/112"  # WG IPv6 sub/net
 
## IPv4 ##
$IPT -t nat -I POSTROUTING 1 -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -I INPUT 1 -i $WG_FACE -j ACCEPT
$IPT -I FORWARD 1 -i $IN_FACE -o $WG_FACE -j ACCEPT
$IPT -I FORWARD 1 -i $WG_FACE -o $IN_FACE -j ACCEPT
$IPT -I INPUT 1 -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT
 
## IPv6 (Uncomment) ##
## $IPT6 -t nat -I POSTROUTING 1 -s $SUB_NET_6 -o $IN_FACE -j MASQUERADE
## $IPT6 -I INPUT 1 -i $WG_FACE -j ACCEPT
## $IPT6 -I FORWARD 1 -i $IN_FACE -o $WG_FACE -j ACCEPT
## $IPT6 -I FORWARD 1 -i $WG_FACE -o $IN_FACE -j ACCEPT
```

```sh
#!/bin/bash
IPT="/sbin/iptables"       
 
IN_FACE="enp2s0"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC 

$IPT -A FORWARD -i $WG_FACE -j ACCEPT
$IPT -A FORWARD -o $WG_FACE -j ACCEPT
$IPT -t nat -A POSTROUTING -o $IN_FACE -j MASQUERADE
```

```sh
#!/bin/bash
IPT="/sbin/iptables"       
 
IN_FACE="enp2s0"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC 

$IPT -D FORWARD -i $WG_FACE -j ACCEPT;
$IPT -D FORWARD -o $WG_FACE -j ACCEPT;
$IPT -t nat -D POSTROUTING -o $IN_FACE -j MASQUERADE
```


```
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```


```
PrivateKey = gLnxJIbAS1JtGtU+3jgevka3eFHQUJ1F6f6tJldHIGo=  
  
## Client ip address ##  
Address = 192.168.100.14/24  
  
## DNS server for WG client #  
## Syntax is  
## DNS = 1.1.1.1, 8.8.8.8  
## I am setting my VLAN's DNS but you can use Google, CF, IBM or anything that works with your WG #  
DNS = 8.8.8.8  
  
[Peer]  
## Remote Ubuntu 20.04 wg0 server public key ##  
PublicKey = Bp8YMGl0Ip0KhEjEhUSs9gI6zE3S9lEM/spjsuxZYBo=  
  
## set ACL ##  
#################################################  
## Allow remote server as gateway  
## Edit/Update old AllowedIPs entry as follows  
## Otherwise client won't show server's IP  
#################################################  
AllowedIPs = 0.0.0.0/0  
  
## Your Ubuntu 20.04 LTS server's public IPv4/IPv6 address and port ##  
Endpoint = foxer19.hopto.org:51194  
  
## Key connection alive ##  
PersistentKeepalive = 15
```



### Install wireguard
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# and run those commands at the root of the project

cargo build --package wstunnel-cli
target/debug/wstunnel ...

# OR
https://github.com/erebe/wstunnel/releases/download/v10.5.1/wstunnel_10.5.1_linux_amd64.tar.gz
tar -xfvz wstunnel_10.5.1_linux_amd64.tar.gz
```

```
From client to server

Internet HTTPS 443
        ↓
     Nginx
        ↓  (WebSocket)
   wstunnel :8080
        ↓  (UDP)
   WireGuard :51194

```

```
Client → HTTPS → yourdomain.com → HTTPS response
```

```
nginx

	location /wg/ {
    	
	        proxy_pass http://127.0.0.1:3002;

        	proxy_http_version 1.1;
        	proxy_set_header Upgrade $http_upgrade;
        	proxy_set_header Connection "upgrade";

        	proxy_set_header Host $host;
        	proxy_set_header X-Real-IP $remote_addr;
        	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        	# Important for long-lived tunnels
        	proxy_read_timeout 1d;
        	proxy_send_timeout 1d;

        	# Disable buffering (VERY IMPORTANT)
        	proxy_buffering off;
	
	}


```

```
sudo systemctl reload nginx
```

On the server side

```
wstunnel server ws://127.0.0.1:3002 --restrict-to=127.0.0.1:51194
```

##### On the client side

Opens local UDP port 51821, WireGuard sends packets here.
Each packet is wrapped into:
- a WebSocket frame    
- tagged with metadata:
    - protocol = UDP
    - destination = `127.0.0.1:51194`

```
./wstunnel client -L udp://51821:127.0.0.1:51194 wss://foxer19.hopto.org/wg/
```


In another shell on the same the `WSTunnel server` Linux server I ran `ncat` listening for UDP traffic on port 51820:

```
ncat -u -l 127.0.0.1 51820
```

### Next

```
useradd -r -s /usr/sbin/nologin wstunnel

ip rule show
ip route show table novpn
ip route add default via $GATEWAY dev $INTERFACE table novpn
ip route add default via 10.44.80.1 dev wlp0s20f3 table novpn    
sudo ip rule add fwmark 1 table novpn;
sudo ip rule del fwmark 1 table novpn;
ip rule add priority 100 fwmark 1 table novpn

add:  iptables -t mangle -A OUTPUT -m owner --uid-owner wstunnel -j MARK --set-mark 51820
del:  iptables -t mangle -D OUTPUT -m owner --uid-owner wstunnel -j MARK --set-mark 51820
show: iptables -t mangle -L OUTPUT -v

ip route add default via 192.168.123.31 dev wlp0s20f3 table novpn 
ip rule add uidrange 997-997 lookup novpn priority 100


ip rule add uidrange 997-997 lookup novpn priority 100
sudo -u wstunnel wstunnel client --dns-resolver dns://1.1.1.1 -L udp://51821:127.0.0.1:51194 wss://foxer19.hopto.org



sudo nano /etc/iproute2/rt_tables
```

## FTP

sudo useradd -r -s /usr/sbin/nologin wstunnel

sudo nano /etc/systemd/system/wstunnel.service

  

[Unit]

Description=WebSocket Tunnel (wstunnel)

After=network-online.target

Wants=network-online.target

  

[Service]

Type=simple

User=wstunnel

Group=wstunnel

  

ExecStart=/usr/local/bin/wstunnel server ws://0.0.0.0:3003 --restrict-to=127.0.0.1:51194

  

Restart=always

RestartSec=3

LimitNOFILE=1048576

  

NoNewPrivileges=true

PrivateTmp=true

ProtectSystem=strict

ProtectHome=true

  

[Install]

WantedBy=multi-user.target

  
  
  

sudo systemctl daemon-reexec

sudo systemctl daemon-reload

sudo systemctl enable wstunnel

sudo systemctl start wstunnel

systemctl status wstunnel

  

  
  

lsblk

Create a mount point: udo mkdir -p /mnt/ftpdrive

Mount the hard drive: sudo mount /dev/sdb1 /mnt/ftpdrive

Make the mount permanent (VERY IMPORTANT):

  

sudo blkid /dev/sdb1 -> UUID="a1b2c3d4-e5f6-7890" TYPE="ext4"

sudo nano /etc/fstab <- UUID=A046-6977 /media/hd1/ exfat defaults 0 2

test the setup: sudo mount -a

  

#### FTP

  

sudo apt install vsftpd -y

sudo nano /etc/vsftpd.conf

  

```

listen=YES

listen_ipv6=NO

  

anonymous_enable=NO

local_enable=YES

write_enable=YES

  

chroot_local_user=YES

allow_writeable_chroot=YES

```

  

sudo systemctl restart vsftpd

  
  

sudo adduser ftpuser

sudo usermod -d /mnt/ftpdrive ftpuser

sudo chown -R ftpuser:ftpuser /mnt/ftpdrive

sudo chmod -R 755 /mnt/ftpdrive