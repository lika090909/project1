FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y apache2 && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY birthday-invite.html /var/www/html/index.html 

CMD ["apachectl", "-D", "FOREGROUND"]

EXPOSE 80