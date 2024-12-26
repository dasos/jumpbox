FROM ubuntu

RUN apt-get update -qq \
    && apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install unminimize openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -qq autoremove \
    && apt-get -qq clean
    && yes | /usr/local/sbin/unminimize

RUN mkdir -p /home

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
