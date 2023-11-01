FROM nginx:1.21

COPY ./cert/_wildcard.docker.pem /etc/nginx/ssl/
COPY ./cert/_wildcard.docker-key.pem /etc/nginx/ssl/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf