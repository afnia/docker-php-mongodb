FROM redis:5.0.3-alpine

ENV PHPIZE_DEPS \ 
    autoconf \
    g++ \ 
    gcc \ 
    make \ 
    pkgconf

RUN apk update && apk add supervisor
RUN apk add --no-cache php7 php7-fpm php7-json php7-openssl php7-curl \
    php7-xml php7-phar php7-intl php7-xmlreader php7-ctype \
    php7-mbstring php7-gd php7-pear php7-dev $PHPIZE_DEPS

RUN apk add --no-cache nginx curl openssl-dev openssh-client
RUN pecl install mongodb \
    pecl clear-cache 


WORKDIR /home
COPY ./webapp /home
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/default.conf /etc/nginx/conf.d/default.conf

COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/szzz_custom.ini

COPY config/redis.conf /etc/redis.conf
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]