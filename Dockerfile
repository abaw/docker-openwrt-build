FROM debian:jessie
MAINTAINER abawwu@gmail.com

RUN apt-get update && apt-get install -y git-core build-essential libssl-dev libncurses5-dev unzip subversion mercurial gawk wget sudo man
RUN apt-get install -y remake
RUN apt-get clean
RUN useradd -m -s /bin/bash openwrt

RUN echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt && chmod 0440 /etc/sudoers.d/openwrt

ADD docker-entry.sh /usr/local/bin/docker-entry.sh
ENTRYPOINT ["/usr/local/bin/docker-entry.sh"]
