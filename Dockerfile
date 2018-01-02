FROM golang:1.9.2-alpine3.6

COPY download-frozen-image-v2.sh /

RUN echo "Install build dependencies" && \
    apk --no-cache add \
      bash \
      build-base \
      curl \
      docker \
      git \
      jq \
      openssl \
      python2 \
      py2-pip \
      rsync && \
    echo "Install Go dependencies" && \
    go get -u github.com/golang/dep/cmd/dep && \
    echo "Install AWS SAM LOCAL dependencies" && \
    go get github.com/awslabs/aws-sam-local && \
    echo "Downloading Lambda image" && \
    mkdir -p /docker-images/lambda-python2.7 && \
    /download-frozen-image-v2.sh /docker-images/lambda-python2.7 lambci/lambda:python2.7 && \
    rm /download-frozen-image-v2.sh && \
    echo "Install Spy filewatcher" && \
    cd /tmp && \
    wget -q https://github.com/jpillora/spy/releases/download/1.0.1/spy_linux_amd64.gz && \
    gunzip spy_linux_amd64.gz && \
    chmod 0755 spy_linux_amd64 && \
    mv spy_linux_amd64 /usr/bin/spy && \
    echo "Remove build dependencies" && \
    apk del jq
