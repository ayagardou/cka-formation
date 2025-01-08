FROM ubuntu:latest
MAINTAINER Ariane Gardou

# Install dependencies
RUN apt-get update && apt-get install -y tzdata
RUN apt-get install apache2 --yes

COPY index.html /var/www/html/index.html

CMD ["apachectl", "-D", "FOREGROUND"]
