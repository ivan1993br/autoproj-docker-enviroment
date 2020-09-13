FROM ubuntu:latest

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y pkg-config && \
    apt-get install -y git && \
    apt-get install -y wget && \
    apt-get install -y curl && \
    apt-get install -y sudo && \
    apt-get install -y ruby && \
    apt-get install -y ruby-dev && \
    apt-get install -y locales && \
    apt-get install -y tzdata && \
    apt-get install -y bash-completion && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y git-lfs  && \
    apt-get clean && \
    echo "Binary::apt::APT::Keep-Downloaded-Packages \"true\";" | tee /etc/apt/apt.conf.d/bir-keep-cache && \
    rm -rf /etc/apt/apt.conf.d/docker-clean && \
    rm -rf /tmp/* /var/tmp/*

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && \
    apt-get install -y nano && \
    apt-get install -y vim && \
    apt-get install -y terminator && \
    apt-get install -y man-db && \
    apt-get install -y manpages && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscode.list && \
    apt-get update && \
    apt-get install -y code  && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /microsoft.gpg

RUN export LANGUAGE=en_US.UTF-8; \
    export LANG=en_US.UTF-8; \
    export LC_ALL=en_US.UTF-8; \
    locale-gen en_US.UTF-8; \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Set locales
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV QT_X11_NO_MITSHM=1

ARG USERNAME
ARG UUID
ARG UGID

RUN useradd -m $USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd && \
    usermod --shell /bin/bash $USERNAME && \
    usermod -aG sudo $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

RUN usermod  --uid $UUID $USERNAME && \
    groupmod --gid $UGID $USERNAME

COPY rootfs/ /

CMD ["/bin/bash"]