FROM ubuntu

RUN apt-get update -qq \
    && apt-get -y upgrade \
    && apt-get -y --no-install-recommends install curl openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -qq autoremove \
    && apt-get -qq clean

RUN mkdir -p /home

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
