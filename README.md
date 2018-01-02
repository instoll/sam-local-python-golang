# README

Develop and simulate serverless application locally.

This image is intended to run API Gateway and Lambda Python2.7.

## What this image covers

- This image is Docker-in-Docker to run SAM Local applications.
- Lambda image is stored in `/tmp/*` as tarball to speed up initialization.

## What this image does not cover

- Go shim installation to run Lambda on Python 2.7 so that you could pick favorite shim.
- Run Docker daemon, due to `privilege` mode restriction. See below for more information.

## Example

Docker-in-Docker is tricky because Docker does not allow to modify certain directories during build process.

Therefore you will need to take these steps to make this image work.

### 1. Prepare your Dockerfile

    FROM instoll/sam-local-python-golang:$VERSION

    RUN go get https://github.com/eawsy/aws-lambda-go-net 

    CMD ["/run.sh"]

### 2. Inject entry script and run with privilege mode enabled.

Tested with Docker Compose version 2.

    version: "2"
    services:
      api:
        build: api
        volumes:
          - ./your-host-dir/run.sh:/run.sh
        privileged: true

The typical `/run.sh` looks like this:

    #!/bin/sh

    # Run Docker daemon in background.
    nohup dockerd &

    # Sleep for a while to make sure the daemon is up and running.
    sleep 2

    # Load built-in image into container.
    tar -cC /docker-images/lambda-python2.7 | docker load
    rm -Rf /docker-images/lambda-python2.7

    # Start API Gateway simulator.
    aws-sam-local local start-api
