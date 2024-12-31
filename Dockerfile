FROM ubuntu

# First unminimize
RUN apt-get update -qq \
    && apt-get -y upgrade \
    && apt-get -y --no-install-recommends install unminimize \
    && yes | unminimize

# Then install some other packages
RUN apt-get update -qq \
    && apt-get -y upgrade \
    && apt-get -y --no-install-recommends install openssh-server curl nano sudo iputils-ping net-tools bash-completion

# Clean up to minimise the image size
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get -qq autoremove \
    && apt-get -qq clean

RUN mkdir -p /home

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
