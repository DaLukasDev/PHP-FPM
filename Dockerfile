ARG PHP_VERSION=8.4

FROM php:${PHP_VERSION}-fpm-alpine

RUN apk --no-cache update && apk --no-cache add jpegoptim optipng pngquant gifsicle tzdata postgresql-client ghostscript

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions pdo_mysql zip exif pcntl gd intl redis opcache bcmath pdo_pgsql pgsql imagick @composer

ADD ./configs/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
ADD ./configs/init.sh /init.sh

RUN addgroup -g 1000 -S www && \
    adduser -u 1000 -S www -G www

RUN chown www:www /init.sh && \
    chmod +x /init.sh

USER www
ENTRYPOINT [ "/init.sh" ]
