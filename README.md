
Docker lamp environment. 
- apache2.4
- php74
- mariaDB
- wp-cli
- composer
- mailhog
- ssl

# Getting Started

## Requirements

- [Docker for mac](https://docs.docker.com/docker-for-mac/install/)
- [mkcert](https://github.com/FiloSottile/mkcert)
- [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html)

## Setup

### Setup cert, dnsmasq  

)dnsmasq reference:  
https://nextat.co.jp/staff/archives/248

```
# if you dont' have.

brew install mkcert

brew install dnsmasq

# set dnsmasq, first time only

echo 'address=/docker/127.0.0.1' >> /usr/local/etc/dnsmasq.conf

sudo mkdir -v /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" >> /etc/resolver/docker'

# start dnsmasq
sudo brew services start dnsmasq

# if you already started dnsmasq
sudo brew services restart dnsmasq

# clear dns cache
sudo killall -HUP mDNSResponder
```
### Clone this repository

```
git clone https://github.com/YuzuruSano/docker-lamp.git
```

### Edit `./docker-compose.yml`

```
~
  db:
   ~
    ports:
      - "{yoursetting(example/13306)}:3306"
    environment:
      MYSQL_ROOT_PASSWORD: '{password}'
  web:
     ~
      ports:
        - '{yoursetting(example/8080)}:80'                    
     ~
```

### Set ssl certs

```
mkcert "*.docker docker"
mv _wildcard.docker-key.pem _wildcard.docker.pem ./cert
```
### Build local server

```
docker-compose build
docker-compose up -d

# test
ping sample.docker 
```

and open http://sample.docker

### Stop local server
```
docker-compose down
```

## Mail

See mailhog.
```
http://localhost:8025/
```
