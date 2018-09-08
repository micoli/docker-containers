FROM php:7.2-fpm-alpine

RUN	apk update && \
	apk add \
		bash \
		gnupg \
		git \
		sudo \
		supervisor\
		wget

### PHP extension dependencies Installation \
RUN apk add \
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
		imagemagick6-dev

### PHP extensions
RUN	docker-php-ext-install \
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
		sockets

RUN apk add $PHPIZE_DEPS

##### PECL PHP extensions
RUN	pecl install apcu  && \
	docker-php-ext-enable apcu && \
	pecl install imagick &&  \
	docker-php-ext-enable imagick && \
	pecl install amqp &&  \
	docker-php-ext-enable amqp

### Npm and node tools
RUN npm install -g \
		curl \
		make \
		nodejs \
		npm \
		bower \
		gulp \
		yarn ; \
	### Composer & Node Installation \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer ; 

#
##### Suppression des caches APT \
#RUN	rm -rf /var/lib/apt/lists/* && \
#	sudo apk clean && \
#	apk autoremove -y --purge
#
#### Application placeholders & polish
RUN  mkdir /application && \
	chown www-data:www-data /application && \
	chown www-data:www-data /var/www

COPY ./entrypoint.sh /
COPY ./php-ini-overrides.ini /etc/php/7.2/fpm/conf.d/99-overrides.ini
RUN chmod a+x /entrypoint.sh

EXPOSE 80
EXPOSE 443

WORKDIR /application

ENTRYPOINT ["/entrypoint.sh"]
CMD ["runner"]

