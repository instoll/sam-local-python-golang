FROM amazonlinux:2017.03.0.20170812

# Setup Golang environments.
ENV GOROOT  /usr/lib/go
ENV GOPATH  /go
ENV PATH    $PATH:$GOROOT/bin:$GOPATH/bin

RUN echo "Install build dependencies" && \
    yum -y install \
      docker \
      gcc \
      git \
      make \
      rsync \
      wget

WORKDIR /tmp

RUN echo "Install Go dependencies" && \
    curl -Ls https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz -o go.tar.gz && \
    tar -xzf go.tar.gz && \
    mv go /usr/lib && \
    rm go.tar.gz && \
    echo "Install Golang dependency management tool" && \
    go get -u github.com/golang/dep/cmd/dep

RUN echo "Install SAM Local dependencies" && \
    curl -Ls https://github.com/awslabs/aws-sam-local/releases/download/v0.2.4/sam_0.2.4_linux_amd64.tar.gz -o sam.tar.gz && \
    tar -xzf sam.tar.gz && \
    ls -la . && \
    mv sam /usr/local/bin && \
    rm -Rf sam.tar.gz

RUN echo "Install Lambda dependencies" && \
    yum -y install python27 && \
    curl https://bootstrap.pypa.io/ez_setup.py | /usr/bin/python27 && \
    easy_install pip && \
    echo "alias python='python27'" >> ~/.bashrc && \
    source ~/.bashrc && \
    pip install pip --upgrade
