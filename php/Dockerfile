FROM php:7.2-fpm-alpine

ENV COMPOSER_MEMORY_LIMIT=-1
ENV COMPOSER_HOME /application/.composer

RUN	apk update && \
	apk add --no-cache \
		bash \
		gnupg \
		git \
		sudo \
		supervisor\
		wget \
		curl \
		make \
		jq \
		nodejs \
		npm \
    ### PHP extension dependencies Installation \
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
    ### PHP extensions \
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
    pecl install apcu  && \
	docker-php-ext-enable apcu && \
	pecl install imagick &&  \
	docker-php-ext-enable imagick && \
	pecl install amqp &&  \
	docker-php-ext-enable amqp; \
    ### Npm and node tools \
	npm install -g \
		bower \
		gulp \
		yarn ; \
    #### Application placeholders & polish \
    mkdir /application && \
	chown www-data:www-data /application && \
	chown www-data:www-data /var/www; \
    mkdir $COMPOSER_HOME && \
    chmod 777 $COMPOSER_HOME && \
    chown -R www-data:www-data $COMPOSER_HOME;\
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer;\
    sudo -E -u www-data composer global require hirak/prestissimo;
    
##### Suppression des caches APT \
#    rm -rf /var/lib/apt/lists/* && \
#	sudo apk clean && \
#	apk autoremove -y --purge

COPY ./entrypoint-php.sh /entrypoint-php.sh
COPY install.docker.cli.sh /usr/local/bin/install.docker.cli.sh
COPY ./php-ini-overrides.ini /etc/php/7.2/fpm/conf.d/99-overrides.ini

RUN chmod a+x /entrypoint-php.sh;\
    chmod a+x /usr/local/bin/install.docker.cli.sh;

EXPOSE 80
EXPOSE 443

WORKDIR /application

ENTRYPOINT ["/entrypoint-php.sh"]
CMD ["runner"]

