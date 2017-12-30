FROM golang:1.9.2-alpine3.6

RUN echo "Install build dependencies" && \
    apk --no-cache add \
      bash \
      build-base \
      curl \
      docker \
      git \
      jq \
      make \
      openssl \
      python2 \
      py2-pip \
      rsync \
      wget && \
    echo "Install Go dependencies" && \
    go get -u github.com/golang/dep/cmd/dep && \
    echo "Install AWS SAM LOCAL dependencies" && \
    go get github.com/awslabs/aws-sam-local

COPY download-frozen-image-v2.sh /

RUN echo "Downloading Lambda image" && \
    /download-frozen-image-v2.sh /tmp lambci/lambda:python2.7
