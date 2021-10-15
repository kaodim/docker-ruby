FROM ubuntu:20.04
SHELL ["/bin/bash", "-Eeuxo", "pipefail", "-c"]
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends bzr git mercurial openssh-client subversion procps && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND noninteractive
RUN echo 'deb http://security.ubuntu.com/ubuntu bionic-security main' >> /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y --no-install-recommends autoconf automake bzip2 file g++ gcc imagemagick libbz2-dev libc6-dev libcurl4-openssl-dev libdb-dev libevent-dev libffi-dev libgdbm-dev libgeoip-dev libglib2.0-dev libjpeg-dev libkrb5-dev liblzma-dev libmagickcore-dev libmagickwand-dev libmysqlclient-dev libncurses-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libtool libwebp-dev libxml2-dev libxslt-dev libyaml-dev make patch xz-utils zlib1g-dev software-properties-common && \
     rm -rf /var/lib/apt/lists/*

# Install RVM
RUN apt-add-repository -y ppa:rael-gc/rvm && \
    apt-get update -y -qq && \
    apt-get install -y -qq rvm && \
    rm -rf /var/lib/apt/lists/*

# Set timezone for tzdata
ENV TZ=Etc/UTC
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

###############################################################################
# OPTION 2: Install Ruby 2.4.10 through RVM
RUN bash -lc 'rvm install ruby-2.4.10' && \
    bash -lc 'rvm cleanup all' && \
    bash -lc 'rvm --default use ruby-2.4.10'
CMD ["bash", "-lc", "irb"]
