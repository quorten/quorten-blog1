---
layout: post
title: Configuring Rocket.Chat chat server
author: quorten
date: 2018-08-26 01:22
categories: [random-software]
tags: [random-software]
---

I tried setting up a Rocket.Chat server and playing around with it.
These are the commands I used to set it up, and some notes about other
things I've found out about Rocket.Chat.

<!-- more -->

```
# 20160827/https://rocket.chat/docs/installation/minimum-requirements
# 20160827/https://rocket.chat/docs/installation/manual-installation/centos/
# Important note on problematic E-mail domain checking, and how to
# disable.  Note that you can set environment variables to change
# the settings, but only before the first time you run the server
# will they take effect.  Then, they will be read from the database
# on subsequent runs.
# 20160828/https://github.com/RocketChat/Rocket.Chat/issues/2895

# IMPORTANT NOTE: One caveat with my configuration below is that I
# run the Rocket.chat server as root.  We probably want to run it
# under a lower user account so that some security breach can't
# cause a malignant process to read directly from the DB files etc.
# Or maybe this is a non-issue when inside an isolated VM/container.

# Note: This syntax is setup to only work with GNU Sed.
# Note: selinux is already disabled in images, so we don't
# need to do anything here.
# sed -i -e '/^selinux=/c\selinux=disabled' /etc/selinux/config
# I think we don't need to technically install nano here to get
# Rocket.chat working.
# yum -y install epel-release nano && yum -y update
yum -y install epel-release && yum -y update
reboot

# Continue after boot.
cat <<EOF >/etc/yum.repos.d/mongodb.repo
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1
EOF
yum install -y nodejs curl GraphicsMagick npm mongodb-org-server mongodb-org
npm install -g inherits n
# This is a newly installed shorthand command to install a
# specific version of node.js.
n 0.10.40
cd /root
curl -L https://rocket.chat/releases/latest/download -o rocket.chat.tgz
tar zxvf rocket.chat.tgz
mv bundle Rocket.Chat
cd Rocket.Chat/programs/server
npm install
cd ../..

## This is just manual verification, up to the point when
## we automate it.
#export PORT=3000
## NOTE: Make sure to substitute the proper hostname/IP here.
#export ROOT_URL=http://192.168.0.11:3000/
#export MONGO_URL=mongodb://localhost:27017/rocketchat
#export Accounts_UseDNSDomainCheck=false
#systemctl start mongod
#iptables -F
#node main.js

## What if you mess up above?  Here's how to start over with the
## database.
#mongo <<EOF
#show dbs;
#use rocketchat;
#db.dropDatabase();
#EOF

# This is where we do the real setup for automatic start on boot.
# Again, remember to substitute the correct hostname/IP address.
cat <<EOF >/usr/lib/systemd/system/rocketchat.service
[Unit]
Description=The Rocket.Chat  server
After=network.target remote-fs.target nss-lookup.target nginx.target mongod.target
[Service]
ExecStart=/usr/local/bin/node /root/Rocket.Chat/main.js
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=rocketchat
User=root
Environment=Accounts_UseDNSDomainCheck=false MONGO_URL=mongodb://localhost:27017/rocketchat ROOT_URL=http://192.168.0.11:3000/ PORT=3000
[Install]
WantedBy=multi-user.target
EOF
chkconfig mongod on
systemctl enable rocketchat.service
systemctl start rocketchat.service

# Okay, cool, that all works nice and well, but it's even
# nicer to have an SSL nginx reverse proxy so as to not let
# any users be victim to rsvlansweep01 sniffing passwords and
# breaking into their account.

# Setup our self-signed SSL certificates, since it is easier
# than Let's Encrypt.

# 20160826/https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04

mkdir /etc/ssl/private
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt <<EOF
US
Minnesota
Minneapolis
Example
Home
192.168.0.11
andrew@example.com
EOF
# Warning: This step is slow, and possibly unnecessary, but it is
# here if you want the extra security.  If you want to skip it, you
# must also delete the "ssl_dhparam" config line below.
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
# Then, maybe to speed things up, go to the VM Console window,
# log into a user account, and type a whole bunch of random key
# strokes.  Or, maybe we're actually lucky and we have hardware
# random number generators attached, so we don't need to do this.

# 20160828/https://rocket.chat/docs/installation/manual-installation/configuring-ssl-reverse-proxy-with-nginx

yum -y install nginx

cat <<EOF >/etc/nginx/conf.d/rocket.chat.conf
# Upstreams
upstream backend {
    server 127.0.0.1:3000;
}

# Redirect to secure
server {
   listen         80;
   server_name    192.168.0.11;
   return         301 https://\$server_name\$request_uri;
}

# HTTPS Server
server {
    listen 443;
    server_name 192.168.0.11;

    error_log /var/log/nginx/rocketchat.access.log;

    ssl on;
    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ssl_session_timeout 5m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # don’t use SSLv3 ref: POODLE
    ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_dhparam /etc/ssl/certs/dhparam.pem;

    location / {
        proxy_set_header X-Forwarded-Ssl on;
        proxy_pass http://127.0.0.1:3000/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$http_host;

        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forward-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forward-Proto http;
        proxy_set_header X-Nginx-Proxy true;

        proxy_redirect off;
    }
}
EOF
chkconfig nginx on
service nginx restart

# WARNING: This will require an admin login as the site URL will
# end up changing, and Rocket.chat will prompt you to update
# this config setting.
```

----------

Create an admin user as your first user.  I just use
E-mail = nobody@example.com, username = admin, password = admin.

Proceed to Administration in the Web UI.

Now, adjust permissions.  Add to user:

* edit-room

* manage-integrations

It seems you may not be able to add custom Emoji in the current
version of Rocket.chat.

20160828/https://github.com/RocketChat/Rocket.Chat/issues/1723

Another adjustment.  Create a #random channel and set
Default to True in Administration > Rooms.

----------

So please summarize, what are the bugs and missing features for
Rocket.chat?

* Threaded messages

* Clickable hashtag searching

* Cannot create custom Emojis.

* Cannot rename user account.

* Cannot delete/deactivate own user account.

20160828/https://github.com/RocketChat/Rocket.Chat/issues/2057

----------

Simple Poll for Rocket.chat.

20160921/https://simplepoll.rocks
20160921/https://github.com/RocketChat/Rocket.Chat/issues/3244
20160921/https://gist.github.com/sampaiodiego/db4b60717e7ac0051024dde23c6a902e
