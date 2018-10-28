# the different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/compose/compose-file/#target

ARG PHP_VERSION=7.2

FROM php:${PHP_VERSION}-fpm-alpine


# persistent / runtime deps
RUN apk add --no-cache \
		acl \
		file \
		gettext \
		git \
		mariadb-client \
	;

ARG APCU_VERSION=5.1.11
RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		coreutils \
		freetype-dev \
		icu-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		libtool \
		libwebp-dev \
		libzip-dev \
		mariadb-dev \
		zlib-dev \
	; \
	\
	docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include --with-webp-dir=/usr/include --with-freetype-dir=/usr/include/; \
	docker-php-ext-configure zip --with-libzip; \
	docker-php-ext-install -j$(nproc) \
		exif \
		gd \
		intl \
		pdo_mysql \
		zip \
	; \
	pecl install \
		apcu-${APCU_VERSION} \
	; \
	pecl clear-cache; \
	docker-php-ext-enable \
		apcu \
		opcache \
	; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --no-cache --virtual .sylius-phpexts-rundeps $runDeps; \
	\
	apk del .build-deps;

RUN apk add --no-cache \
		icu-dev \
		zlib-dev \
		libpng-dev \
		freetype-dev \
		libjpeg-turbo-dev \
		jpeg-dev \
		openjpeg-dev \
		libmcrypt-dev \
		sqlite-dev \
		rabbitmq-c-dev \
		libssh-dev \
		imagemagick6-dev ;\
    docker-php-ext-install \
		exif \
		intl \
		gd \
		zip \
		bcmath \
		pdo \
		mysqli \
		gd \
		pdo_mysql \
		pdo_sqlite \
		opcache \
		sockets ; \
    apk add --no-cache $PHPIZE_DEPS; \
    ##### PECL PHP extensions\
    apk add libmemcached-dev libmemcached; \
    pecl install memcached  && \
	docker-php-ext-enable memcached && \
    pecl install apcu  && \
	docker-php-ext-enable apcu && \
	pecl install imagick &&  \
	docker-php-ext-enable imagick && \
	pecl install amqp &&  \
	docker-php-ext-enable amqp;

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY php.ini /usr/local/etc/php/php.ini

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN set -eux; \
	composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --classmap-authoritative; \
	composer clear-cache
ENV PATH="${PATH}:/root/.composer/vendor/bin"
