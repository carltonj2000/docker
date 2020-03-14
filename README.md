# Home And Digital Ocean Web Setup

The diagram of the setup can be found
[here](https://docs.google.com/drawings/d/13VyCrZbnPymv7wfnjO2jlD06-W2CV74MiILdoC--vvk/edit?usp=sharing).

This repository along with the
[cj](https://github.com/carltonj2000/cj)
repository froms docker machine test setup.

Read the [digital ocean issues](#-Digital-Ocean-Issues) section for issues seen.

Read my google docs on how to renew certificates.

## Nginx Auth


The auth is from
[here](https://www.digitalocean.com/community/tutorials/how-to-set-up-password-authentication-with-nginx-on-ubuntu-14-04).

```bash
echo -n 'carltonj2000:' >> .htpasswd
openssl passwd -apr1 >> .htpasswd
chmod 600 .htpasswd
```

And the corresponding entry in nginx.conf

```
server { 
    root /www/carltonjoseph/;
    ...
    location /test {
        try_files $uri $uri/ =404;
        auth_basic "Restricted Content";
        auth_basic_user_file /www/carltonjoseph/test/.htpasswd;
    }
    ...
}
```

## Nginx Forwarding

The summary below is from
[here](https://www.digitalocean.com/community/questions/configure-nginx-for-nodejs-backend-and-react-frontend-app)
and has not been tried yet. Presently use the basic `proxy_pass` and should
look into seeing if the other parameters provided below are needed.

```
location / {
    # This would be the directory where your React app's static files are stored at
    root /var/www/html/;
    try_files $uri /index.html;
}
location /graphql {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-NginX-Proxy true;
    proxy_pass http://localhost:5000/;
    proxy_ssl_session_reuse off;
    proxy_set_header Host $http_host;
    proxy_cache_bypass $http_upgrade;
    proxy_redirect off;
}
```

## Hosts

Added the following to `/etc/hosts`. Need the `::1` IPv6 duplicated on MAC
so that the name lookup is fast, without it Bounjour get take 5+ seconds
before the lookup completes.

```
127.0.0.1       carltonathome.local
127.0.0.1       carltonwin8.local
127.0.0.1       tinaandcarlton.local
127.0.0.1       appsfortracking.local
127.0.0.1       apps4tracking.local
127.0.0.1       carltonjoseph.local
127.0.0.1       sophieandchampagne.local
127.0.0.1       home-root.local
::1     carltonathome.local
::1     carltonwin8.local
::1     tinaandcarlton.local
::1     appsfortracking.local
::1     apps4tracking.local
::1     carltonjoseph.local
::1     sophieandchampagne.local
::1     home-root.local
```

## Home https

The instruction below were adapted from the
[HTTPS on localhost with NGINX](https://imagineer.in/blog/https-on-localhost-with-nginx/)
article.

- generate and SSL self signed certificate with the following command.
  `openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout homehome.key -out homehome.crt`
- enter the following information at the prompts

```
Country Name (2 letter code) []:US
State or Province Name (full name) []:Nevada
Locality Name (eg, city) []:Las Vegas
Organization Name (eg, company) []:CJ Home
Organizational Unit Name (eg, section) []:Mac
Common Name (eg, fully qualified host name) []:*.home.com
Email Address []:carlton.joseph@gmail.com
```

- view the details of the cert via
  `openssl x509 -text -noout -in localhost.crt`
- Safari and Chrome will use this cert via the keychain by entering the command
  below (note Firefox uses it on internal CA and warn about security)
  `security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain localhost.crt`
- list trusted certificates via
  `security dump-keychain /Library/Keychains/System.keychain`
- remove trusted certificates via
  `secutity delete-certificate -Z hash /Library/Keychains/System.keychain`
- removed via GUI by `Finder->Go.Menu->Utilities->Keychain Access->System->Certificates

## Docker Compose

The commands below should be in the makefile if it has been update.
In an ideal world `make bup` should build all the docker sites and bring up
the docker machines.

docker-compose -f docker-compose-home.yml build
docker-compose -f docker-compose-home.yml up
docker-compose -f docker-compose-home.yml restart <machine>

## Digitalocean Let's Encrypt Certificates

Instructions below are from
[here]()
and
[here](https://certbot-dns-digitalocean.readthedocs.io/en/stable/).

```
certbot certonly \
  --dns-digitalocean \
  --dns-digitalocean-credentials ~/.secrets/certbot/digitalocean.ini \
  -d example.com
```

Where the `digitalocean.ini` file contains an api key from DO as shown below.

```
# DigitalOcean API credentials used by Certbot
dns_digitalocean_token = 0000111122223333444455556666777788889999aaaabbbbccccddddeeeeffff
```

DigitalOcean API credentials are obtained from your DigitalOcean account’s
Applications & API Tokens page

## Digital Ocean Issues

The following issue was seen on Ubuntu 16.04 and Docker x.x but I did not
check to see if this issue existed on 18.04.1 and Docker y.y.

The directory structure will reflect the
[docker machine structure diagram](https://docs.google.com/drawings/d/13VyCrZbnPymv7wfnjO2jlD06-W2CV74MiILdoC--vvk/edit?usp=sharing).
On a digitalocean server the docker daemon failed to auto start the docker
containers on boot when a mounted drive was used. I am guessing because the
mounted drive was not settled down when the docker demon tried to start the
containers. The solution was to start the docker containers from a non mounted
drive and map the mounted drives that contain the bulk data not stored in the
repos (builds, rsync, etc). A mounted drive is used because moving the setup to
a new machine is easier with a mounted drive and there is more space on a
mounted drive vs the host non mounted drive. With this setup there was no issue
on auto starting the container on the system boot. The same setup will be
duplicated on my local machine in order to have a consistent set up between my
local and hosted machines.
