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

## Setup

```
# if you dont' have.
brew install mkcert
```

```
git clone https://github.com/YuzuruSano/docker-lamp.git
```

### 1.Edit `./docker-compose.yml`

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

### 2.Set ssl certs

```
mkcert "*.docker docker"
mv _wildcard.docker-key.pem _wildcard.docker.pem ./cert
```

### 3.Build local server

```
docker-compose build
docker-compose up -d
```

### 4.Install WordPress

```
docker-compose exec php-fpm composer create-project roots/bedrock src
```

### Stop local server

```
docker-compose down
```

## Mail

See mailhog.

```
http://localhost:8025/
```
