FROM micoli/docker-containers:php-latest

RUN	apk update && \
	apk add \
		nodejs \
		npm \
		vim \
		zsh \
		tmux \
		iputils \
		make \
		shadow;\
    ### Composer & Node Installation \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer ; \
	\
	### Npm and node tools \
	npm install -g \
		bower \
		gulp \
		yarn ;

RUN echo "%www-data ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers;\
	usermod --shell /bin/zsh www-data;\
	usermod --home /var/www www-data

COPY ./entrypoint.sh /
RUN chmod a+x /entrypoint.sh

RUN echo "Misc" ;\
    ### install gitlab ;\
    wget  https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64 -O /usr/local/bin/gitlab-runner ;\
    chmod +x /usr/local/bin/gitlab-runner 

USER  www-data

COPY home/user/zshrc .zshrc
COPY home/user/tmux.conf .tmux.conf
COPY home/user/install.docker.cli.sh install.docker.cli.sh

RUN cd /var/www; \
    zsh ./install.docker.cli.sh; \
	mkdir .ssh ; \
	sudo chown www-data:www-data /var/www; \
    sudo chmod 700 .ssh; \
	echo "" > .ssh/id_rsa; \
	chmod 600 .ssh/id_rsa; \
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)";\
    composer global require hirak/prestissimo

WORKDIR /application

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

