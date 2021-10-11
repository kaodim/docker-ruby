FROM ubuntu:20.04
SHELL ["/bin/bash", "-Eeuxo", "pipefail", "-c"]
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends bzr git mercurial openssh-client subversion procps && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND noninteractive
RUN echo 'deb http://security.ubuntu.com/ubuntu bionic-security main' >> /etc/apt/sources.list
RUN apt-get update && apt-cache policy libssl1.0-dev && \
    apt-get install -y --no-install-recommends autoconf automake bzip2 file g++ gcc imagemagick libbz2-dev libc6-dev libcurl4-openssl-dev libdb-dev libevent-dev libffi-dev libgdbm-dev libgeoip-dev libglib2.0-dev libjpeg-dev libkrb5-dev liblzma-dev libmagickcore-dev libmagickwand-dev libmysqlclient-dev libncurses-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libtool libwebp-dev libxml2-dev libxslt-dev libyaml-dev make patch xz-utils zlib1g-dev libssl1.0-dev software-properties-common && \
     rm -rf /var/lib/apt/lists/*

# Ruby 231 needs the 1.0 openssl while ubuntu 20 use openssl 1.1
RUN apt-cache policy libssl1.0-dev && apt-install libssl-dev=1.0.2n-1ubuntu5.7 && rm -rf /var/lib/apt/lists/*

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
# OPTION 1 (have openssl issue)
# Build ruby 2.3.1 from scratch
#ENV RUBY_VERSION=2.3.1
#ENV RUBY_VERSION=2.3.1
#ENV RUBY_DOWNLOAD_SHA256=b87c738cb2032bf4920fef8e3864dc5cf8eae9d89d8d523ce0236945c5797dcd
#ENV RUBYGEMS_VERSION=2.6.8
#
#RUN /bin/sh -c set -ex && \
#    buildDeps='bison libgdbm-dev ruby' && \
#    apt-get update && \
#    apt-get install -y --no-install-recommends $buildDeps && \
#    rm -rf /var/lib/apt/lists/* && \
#    wget -O ruby.tar.gz "https://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" && \
#    echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c - && \
#    mkdir -p /usr/src/ruby && \
#    tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 && \
#    rm ruby.tar.gz && \
#    cd /usr/src/ruby && \
#    { echo '#define ENABLE_PATH_CHECK 0'; echo; cat file.c; } > file.c.new && \
#    mv file.c.new file.c && \
#    autoconf && \
#    ./configure --disable-install-doc && \
#    make -j"$(nproc)" && \
#    make install && \
#    apt-get purge -y --auto-remove $buildDeps && \
#    cd / && \
#    rm -r /usr/src/ruby && \
#    gem update --system "$RUBYGEMS_VERSION"
#
#ENV BUNDLER_VERSION=1.16.6
#RUN /bin/sh -c gem install bundler --version "$BUNDLER_VERSION"
#ENV GEM_HOME=/usr/local/bundle
#ENV BUNDLE_PATH=/usr/local/bundle BUNDLE_BIN=/usr/local/bundle/bin BUNDLE_SILENCE_ROOT_WARNING=1 BUNDLE_APP_CONFIG=/usr/local/bundle
#ENV PATH=/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#RUN /bin/sh -c mkdir -p "$GEM_HOME" "$BUNDLE_BIN" && chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

###################################################################################
# OPTION 2: Install Ruby 2.3.1 through RVM
RUN bash -lc 'rvm install ruby-2.3.1' && \
    bash -lc 'rvm cleanup all' && \
    bash -lc 'rvm --default use ruby-2.3.1'
CMD ["bash", "-lc", "irb"]
