FROM eawsy/aws-lambda-go-shim:latest

ENV GOPATH  /go
ENV PATH    $GOPATH/bin:$PATH
ENV SAM_LOCAL_VERSION 0.2.10

RUN echo "Install OS dependencies" && \
    yum -y install \
      findutils \
      git \
      rsync \
      wget \
      zip && \
    echo "Install Go dependencies" && \
    go get -u github.com/golang/dep/cmd/dep && \
    echo "Install Spy filewatcher" && \
    cd /tmp && \
    wget -q https://github.com/jpillora/spy/releases/download/1.0.1/spy_linux_amd64.gz && \
    gunzip spy_linux_amd64.gz && \
    chmod 0755 spy_linux_amd64 && \
    mv spy_linux_amd64 /usr/bin/spy && \
    echo "Install AWS SAM LOCAL dependencies" && \
    wget https://github.com/awslabs/aws-sam-local/releases/download/v${SAM_LOCAL_VERSION}/sam_${SAM_LOCAL_VERSION}_linux_amd64.tar.gz && \
    tar xzvf sam_${SAM_LOCAL_VERSION}_linux_amd64.tar.gz && \
    mv sam /usr/bin/aws-sam-local && \
    echo "Install Caddy HTTP server.." && \
    curl https://getcaddy.com | bash -s personal http.cors
