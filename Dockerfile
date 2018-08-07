FROM eawsy/aws-lambda-go-shim:latest

ENV GOPATH  /go
ENV PATH    $GOPATH/bin:$PATH

RUN echo "Install OS dependencies" && \
    yum -y install \
      findutils \
      git \
      python27-devel \
      python27-pip \
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
    echo "Install AWS SAM CLI dependencies" && \
    pip install aws-sam-cli && \
    echo "Install Caddy HTTP server.." && \
    curl https://getcaddy.com | bash -s personal http.cors
