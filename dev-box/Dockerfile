FROM library/ubuntu:16.04

ENV USER www-data

RUN rm -rf /var/lib/apt/lists/*;\
	apt-get update;\
	apt-get install -y \
		apt-transport-https \
		ca-certificates \
		wget \
		software-properties-common \
		samba \
		openssh-server \
		supervisor \
		sudo

#install docker
RUN wget https://download.docker.com/linux/ubuntu/gpg;\
	apt-key add gpg;\
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable";\
	apt-get update;\
	apt-cache policy docker-ce;\
	apt-get -y install docker-ce

#parameters for SSH
RUN $(echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers); \
	$(echo "sshd: ALL" >> /etc/hosts.allow); \
	mkdir /var/run/sshd ;\
	sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config ;\
	sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#parameters for user
RUN useradd -d /home/$USER -ms /bin/bash -g root -G sudo $USER;\
    echo "$USER:$USER" | chpasswd

#parameters for SAMBA
RUN (echo $USER; echo $USER) | smbpasswd -a $USER

#parameters for Supervisor
COPY etc/supervisor/conf.d/supervisord.conf etc/supervisor/conf.d/supervisord.conf

#parameters for USER
RUN	usermod --shell /bin/zsh $USER

RUN apt-get install -y \
		zsh \
        vim \
        tmux \
        tmate \
        inetutils-ping \
        make

EXPOSE 22
EXPOSE 445/tcp

RUN usermod -m -d /var/www www-data; \
    mkdir /var/www ;\
    chown www-data:www-data /var/www

COPY etc/samba/smb.conf /etc/samba/smb.conf


RUN echo "annexe" ;\
    ### install gitlab ;\
    #wget  https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64 -O /usr/local/bin/gitlab-runner ;\
    #chmod +x /usr/local/bin/gitlab-runner ;\
    ### install docker-compose ;\
    wget  https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -O /usr/local/bin/docker-compose 2>/dev/null ;\
    chmod +x /usr/local/bin/docker-compose ;

USER $USER
ENV TERM xterm

COPY home/user/zshrc .zshrc
COPY home/user/tmux.conf .tmux.conf
COPY home/user/install.docker.cli.sh install.docker.cli.sh

RUN cd /var/www; mkdir .ssh ; sudo chmod 700 .ssh; echo "" > .ssh/id_rsa; chmod 600 .ssh/id_rsa

ADD home/user/id_rsa /var/www/.ssh/id_rsa
RUN sudo chmod 600 /var/www/.ssh/id_rsa; sudo chown www-data:www-data /var/www/.ssh/id_rsa

RUN sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)";exit 0


#back to root to finish
USER root
#ENTRYPOINT ["/bin/sh"]
#CMD ["-c","/bin/bash"]


CMD ["/usr/bin/supervisord"]
