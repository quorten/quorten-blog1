---
layout: post
title: Configuring Mattermost chat server
author: quorten
date: 2016-08-26 22:52 -0500
categories: [random-software]
tags: [random-software]
---

I tried setting up a Mattermost server and playing around with it.
These are the commands I used to set it up, and some notes about other
things I've found out about Mattermost.

<!-- more -->

```
# Setup a RHEL 6.6 x86_64 VM, size Large more-storage, additional
# partition on mount point /mmstore, full size, filesystem XFS, and no
# additional software selected for install.

# ssh root@HOST

# PIPE this in as standard input, i.e. send this as standard input.
# DO NOT place these commands in a shell script.

# 20160826/https://docs.mattermost.com/install/prod-rhel-6.html

yum -y install http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-redhat94-9.4-1.noarch.rpm
yum -y install postgresql94-server postgresql94-contrib
service postgresql-9.4 initdb
chkconfig postgresql-9.4 on
service postgresql-9.4 start
su - postgres <<EOF
psql <<EOOF
CREATE DATABASE mattermost;
CREATE USER mmuser WITH PASSWORD 'mmuser_password';
GRANT ALL PRIVILEGES ON DATABASE mattermost to mmuser;
\q
EOOF
EOF
# Warning: Contains tab, use Control+V when typing interactively.
sed -i -e "s/^#listen_addresses = 'localhost'\\(.*\\)\$/"\
"listen_addresses = '*'	\\1/g" \
  /var/lib/pgsql/9.4/data/postgresql.conf
## Warning: Requires GNU Sed.
# sed -i -e '/^\(host  *all  *all  *127.0.0.1\/32  *\)ident$/a\'\
# 'host    all             all             10.10.10.2/32           md5' \
#   /var/lib/pgsql/9.4/data/pg_hba.conf
# NOTE: Use this one instead if you are running PostgreSQL locally.
# NOTE: Beware, though, as you'll need a password for subsequent
# local logins.
sed -i -e 's_^\(host  *all  *all  *127.0.0.1/32  *\)ident$_\1md5_' \
  /var/lib/pgsql/9.4/data/pg_hba.conf
service postgresql-9.4 restart
touch ~/.pgpass; chmod go-rwx ~/.pgpass
# The purpose of the following lines is to test that the database
# is working.  It's not much point to automate this.  To run
# interactively, you can use --password on `psql' and avoid creating
# the ~/.pgpass file.
cat <<EOF >~/.pgpass
127.0.0.1:*:mattermost:mmuser:mmuser_password
EOF
psql --host=127.0.0.1 --dbname=mattermost --username mmuser <<EOF
\q
EOF
rm ~/.pgpass

wget https://releases.mattermost.com/3.3.0/mattermost-team-3.3.0-linux-amd64.tar.gz
tar -xvzf mattermost-team-3.3.0-linux-amd64.tar.gz
mv mattermost /opt
mkdir -p /mmstore/data
useradd -r mattermost -U
chown -R mattermost:mattermost /opt/mattermost
chmod -R g+w /opt/mattermost
chown -R mattermost:mattermost /mmstore/data
chmod -R g+w /mmstore/data
# SUBSTITUTE with a LOCAL non-root user account!
usermod -a -G mattermost cloud-user
sed -i -e 's/^\( *"DriverName"\): "mysql",$/\1: "postgres",/' \
  -e 's|^\( *"DataSource"\): "mmuser:mostest@tcp(dockerhost:3306)/mattermost_test?charset=utf8mb4,utf8",$|'\
'\1: "postgres://mmuser:mmuser_password@127.0.0.1:5432/mattermost?sslmode=disable\&connect_timeout=10",|' \
  -e 's_^\( *"Directory"\): "./data/",$_\1: "/mmstore/data/",_' \
  -e 's/^\( *"EnableConsole"\): true,$/\1: false,/' \
  -e 's/^\( *"VaryByRemoteAddr"\): true,$/\1: false,/' \
  -e 's/^\( *"VaryByHeader"\): ""$/\1: "X-Real-IP"/' \
  /opt/mattermost/config/config.json

cp -pR /etc/skel/ /home/mattermost
chown mattermost:mattermost /home/mattermost/
su - mattermost <<EOF
cd /opt/mattermost/bin
# Testing, type Control-C to exit if you chose to run.
./platform &
sleep 2
kill -INT %1
EOF

cat <<EOF >/etc/init/mattermost.conf
start on runlevel [2345]
stop on runlevel [016]
respawn
chdir /opt/mattermost
exec bin/platform
EOF
start mattermost

cat <<EOF >/etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/rhel/6/\$basearch/
gpgcheck=0
enabled=1
EOF
yum -y install nginx.x86_64
service nginx start
chkconfig nginx on
# NOTE: Use a proper FQDN in server_name if possible.
cat <<EOF >/etc/nginx/conf.d/mattermost.conf
server {
  server_name 192.168.0.10;

  location / {
     client_max_body_size 50M;
     proxy_set_header Upgrade \$http_upgrade;
     proxy_set_header Connection "upgrade";
     proxy_set_header Host \$http_host;
     proxy_set_header X-Real-IP \$remote_addr;
     proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
     proxy_set_header X-Forwarded-Proto \$scheme;
     proxy_set_header X-Frame-Options SAMEORIGIN;
     proxy_pass http://127.0.0.1:8065;
  }
}
EOF
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak

## NOTE: Do not do the following.  It does not work, probably
## because we're not running the latest version, or maybe because
## this whole section was written more with Debian systems in mind
## than Red Hat.
## Maybe I can investigate this to go fix it later.
#yum -y install git
#su - cloud-user
#git clone https://github.com/letsencrypt/letsencrypt
#exit
#service nginx stop
#netstat -na | grep ':80.*LISTEN'
#cd /home/cloud-user/letsencrypt
#./letsencrypt-auto certonly --standalone

# Now navigate to http(s)://MATTERMOST-HOST and continue to
# configure in the GUI.

# The most important thing you need to configure in the GUI from
# here is E-mail.

# Here's how to create self-signed certificates as an easier
# alternative to Let's Encrypt.

# 20160826/https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04

mkdir /etc/ssl/private
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt <<EOF
US
Minnesota
Minneapolis
Example
Home
192.168.0.10
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

# Okay, now this should work to get us up and running with HTTPS locally.
# Remember, we're replacing our previous insecure configuration with
# our new secure one.

mv /etc/nginx/conf.d/mattermost.conf /etc/nginx/conf.d/mattermost.conf.bak
cat <<EOF >/etc/nginx/conf.d/mattermost.conf
server {
   listen         80;
   server_name    192.168.0.10;
   return         301 https://\$server_name\$request_uri;
}

server {
   listen 443 ssl;
   server_name 192.168.0.10;

   ssl on;
   ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
   ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
   ssl_session_timeout 5m;
   ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
   ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
   ssl_prefer_server_ciphers on;
   ssl_session_cache shared:SSL:10m;
   ssl_dhparam /etc/ssl/certs/dhparam.pem;

   location / {
      gzip off;
      proxy_set_header X-Forwarded-Ssl on;
      client_max_body_size 50M;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_set_header Host \$http_host;
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;
      proxy_set_header X-Frame-Options SAMEORIGIN;
      proxy_pass http://127.0.0.1:8065;
   }
}
EOF

service nginx restart

# Team member invite link:
# 20160827/https://192.168.0.10/signup_user_complete/?id=b3a9rq45etbbpyjcn88d3o36cr

# TODO More configuration:
# Enable custom Emoji.
# Disable restrict creating integrations to team and system admins.

# Oh!  The problem and the solution right here!  The last one.
# 20160826/https://github.com/mrjoes/tornadio2/issues/59
# 20160826/https://github.com/reddit/reddit-plugin-liveupdate/issues/100
# 20160826/http://stackoverflow.com/questions/4014055/how-to-debug-safari-silently-failing-to-connect-to-a-secure-websocket
# 20160826/Google Web sockets unable to connect in Safari using self-signed HTTPS
# 20160826/http://blog.marcon.me/post/24874118286/secure-websockets-safari
# 20160826/http://apple.stackexchange.com/questions/220080/how-do-you-remove-ssl-certificate-exceptions-on-os-x
# 20160826/

exit
```

----------

NOTES:

When I was playing around with Mattermost, I left a note about where
to find it on the intranet.  It is no longer up and running anymore at
its old location.

I've setup a Mattermost test server, you can go invite yourself using
the following link:

20160828/https://192.168.0.10/signup_user_complete/?id=b3a9rq45etbbpyjcn88d3o36cr

If you are using Safari, when prompted about the self-signed
certificate, make sure you click the checkbox "Always trust this
certificate" in order for WebSockets to work, otherwise you're not
going to have a very interactive chat experience.  You can remove the
exception later by going to Keychain Access in OS X.

Oh, and make sure you don't use it for conversation not related to
testing Mattermost and setting up integrations because it is setup on
an VM of mine that I might just decide to delete and recreate.

Interesting article on Mattermost:

20160827/https://opensource.com/education/16/3/mattermost-open-source-chat

Important links on integrations:

20160827/https://www.mattermost.org/community-applications/  
20160827/https://github.com/NDrive/sentry-mattermost  
20160827/https://github.com/getsentry/sentry-slack/blob/master/src/sentry_slack/plugin.py  
20160827/https://github.com/getsentry/sentry-slack/blob/master/src/sentry_slack/plugin.py  
20160827/https://github.com/numberly/mattermost-integration-giphy

----------

TODO bot notes:

* Local database

* Translation database

* "Entertainment value" database, other such categorization and
  ranking algorithms.

----------

IMPORTANT: How to backup Mattermost data.

20160827/https://docs.mattermost.com/administration/backup.html

Oh, and custom branding tools?  In case we want to change the
the name of the software?  Only in Enterprise E10 and higher
is it built-in.  Otherwise, you'll have to do your own source-code
modification thing.

20160827/https://docs.mattermost.com/administration/branding.html

Oh yeah, and you can setup mobile too.

20160827/https://docs.mattermost.com/deployment/push.html

----------

Do I not have a direct link to this?  Well, I need to have this one.

20160827/https://www.mattermost.org/what-slack-might-learn-from-its-open-source-alternative/

Missing Emoji picker?  Hey, maybe this one will work.

20160827/https://github.com/OneSignal/emoji-picker

Or maybe not?  Can it be integrated?

Mattersmost.  You can't edit messages in-line.  Add a new feature?
Maybe, maybe not in light of Rocket.chat.

Written in Golang and React.

20160827/https://github.com/mattermost/platform  
20160827/https://docs.mattermost.com/developer/contribution-guide.html  
20160827/https://forum.mattermost.org/t/limited-edition-mattermost-mugs/143

----------

Mattermost issues: Cannot delete/deactivate own user account,
but can do so via the command line.

20160828/https://mattermost.uservoice.com/forums/306457-general/suggestions/9183047-add-ability-to-delete-a-team-member  
20160828/https://docs.mattermost.com/administration/command-line-tools.html?highlight=delete#command-line-tools  
20160828/https://mattermost.atlassian.net/browse/PLT-1798  
20160828/https://github.com/mattermost/platform/pull/2156

Pull request out to add the feature to the GUI, but it needs
improvement and has not been merged yet.
