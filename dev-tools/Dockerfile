FROM micoli/docker-containers:php-latest

RUN	apk update && \
	apk add \
        nodejs \
		vim \
		zsh \
		tmux;\
    ### Composer & Node Installation \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer && \
	\
	### Npm and node tools \
	npm install -g \
		bower \
		gulp \
		yarn ;\
	\
	### Npm and node tools \
	sudo -u www-data composer global require hirak/prestissimo

COPY ./entrypoint.sh /
RUN chmod a+x /entrypoint.sh


WORKDIR /application

ENTRYPOINT ["/entrypoint.sh"]
CMD ["runner"]

