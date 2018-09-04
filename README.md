
Docker lamp environment. 
- apache
- php7-1
- mysql:57
- wp-cli
- composer
- ssmtp

# Getting Started

## Requirements

- [Docker for mac](https://docs.docker.com/docker-for-mac/install/)

## Setup

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

### Edit `./web/Dockerfile`
edit mail setting.

```
~
# root is the person who gets all mail for userids < 1000
RUN echo "root={root mail address}" >> /etc/ssmtp/ssmtp.conf

# Here is the gmail configuration (or change it to your private smtp server)
RUN echo "mailhub={smtpserver&port}" >> /etc/ssmtp/ssmtp.conf
RUN echo "AuthUser={user}" >> /etc/ssmtp/ssmtp.conf
RUN echo "AuthPass={pass}" >> /etc/ssmtp/ssmtp.conf
~
```
### Build local server

```
docker-compose build
docker-compose up -d
```

and open http://sample.localhost:{port}

### Stop local server
```
docker-compose down
```

