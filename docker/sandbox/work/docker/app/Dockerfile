FROM php:8.2.12

RUN docker-php-ext-install pdo_mysql

RUN apt-get update
RUN apt-get install -y msmtp-mta

COPY ./msmtprc /etc/msmtprc
CMD ["/usr/local/bin/php", "--server", "0.0.0.0:8000", "--docroot", "my-work" ]

