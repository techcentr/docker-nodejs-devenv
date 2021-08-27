FROM node:16.8.0-alpine3.13

# Install glibc compatibility for alpine - required by AWS CLI v2
ENV GLIBC_VER=2.31-r0

ADD https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub
ADD https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk /tmp/glibc.apk
ADD https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk /tmp/glibc-bin.apk
ADD https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-i18n-${GLIBC_VER}.apk /tmp/glibc-i18n.apk

# Not required - version is pinned by downloading a specific version of the package
# hadolint ignore=DL3018
RUN apk add --no-cache \
    /tmp/glibc.apk \
    /tmp/glibc-bin.apk \
    /tmp/glibc-i18n.apk && \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    # Clean up
    rm -rf /tmp/glib* \ 
           /var/cache/apk/*

# Install AWS CLI
ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip ./awscliv2.zip

RUN apk add --no-cache groff=1.22.4-r1 less=563-r0 && \
    unzip awscliv2.zip && \
    ./aws/install && \
    # Clean up
    rm -rf ./awscliv2.zip \
           ./aws \
           /usr/local/aws-cli/v2/*/dist/awscli/examples \
           /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index

# Install Docker CLI - useful for local development
RUN apk add --no-cache docker-cli=20.10.3-r1

# Install Git - required for actions/checkout@v2
RUN apk add --no-cache git=2.30.2-r0

ENTRYPOINT [ "ash" ]