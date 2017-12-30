FROM golang:1.9.2-alpine3.6

# Setup Golang environments.
ENV APPROOT /go/src/api/app

RUN echo "Install build dependencies" && \
    apk --no-cache add \
      bash \
      build-base \
      curl \
      docker \
      git \
      make \
      openssl \
      python2 \
      py2-pip \
      rsync \
      wget && \
    echo "Install Go dependencies" && \
    go get -u github.com/golang/dep/cmd/dep

WORKDIR /tmp

RUN echo "Install SAM Local dependencies" && \
    curl -Ls https://github.com/awslabs/aws-sam-local/releases/download/v0.2.4/sam_0.2.4_linux_amd64.tar.gz -o sam.tar.gz && \
    tar -xzf sam.tar.gz && \
    ls -la . && \
    mv sam /usr/local/bin && \
    rm -Rf sam.tar.gz
