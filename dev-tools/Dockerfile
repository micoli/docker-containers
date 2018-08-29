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
		shadow \
		jq \
		lftp \
		httpie;\
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
	usermod --home /var/www www-data;\
	usermod -G root www-data


ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

COPY install.docker.cli.sh /usr/local/bin/install.docker.cli.sh
COPY ./entrypoint.sh /

RUN chmod a+x /entrypoint.sh;\
    chmod a+x /usr/local/bin/install.docker.cli.sh;

RUN echo "Misc" ;\
    ### install gitlab ;\
    echo "Download and install gitlab-runner" ;\
    curl --silent  https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64 -o /usr/local/bin/gitlab-runner ;\
    chmod +x /usr/local/bin/gitlab-runner;\
    curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl && \
    chmod a+x /usr/local/bin/kubectl;\
    kubectl version --client

USER  www-data

WORKDIR /var/www

COPY home/user/zshrc /var/www.zshrc
COPY home/user/tmux.conf /var/www.tmux.conf

RUN mkdir .ssh ; \
	sudo chown www-data:www-data /var/www; \
    sudo chmod 700 .ssh; \
	echo "" > .ssh/id_rsa; \
	chmod 600 .ssh/id_rsa; \
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)";\
    composer global require hirak/prestissimo

WORKDIR /application


