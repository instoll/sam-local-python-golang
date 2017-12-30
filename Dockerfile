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
    echo "Install AWS SAM LOCAL dependencies" && \
    go get github.com/awslabs/aws-sam-local
