---
layout: post
title:  "Extract content from Docker image"
date:   2019-01-06 14:48:26 -0500
categories: docker
---

I learned a new trick to easily copy data from a Docker image to a localhost
using [`docker
create`](https://docs.docker.com/engine/reference/commandline/create/#parent-command)
and [`docker cp`](https://docs.docker.com/engine/reference/commandline/cp/).
This is useful if there's a binary, config file, etc on a Docker image that you
want to use locally.

In this example, we'll copy a Go binary out of the Docker image created from this
[Dockerfile](https://github.com/bksteiny/golang/blob/master/helloworld/Dockerfile).

```sh
~> docker build -t hello .         
Sending build context to Docker daemon  1.923MB
Step 1/9 : FROM golang:alpine AS builder
 ---> f56365ec0638
Step 2/9 : RUN apk update && apk add --no-cache git
 ---> Using cache
 ---> 014468fc35b9
Step 3/9 : COPY helloworld.go $GOPATH/src/hello/
 ---> Using cache
 ---> e8ddd00c399d
Step 4/9 : WORKDIR $GOPATH/src/hello/
 ---> Using cache
 ---> b3f6b9cd6ec9
Step 5/9 : RUN go get -d -v
 ---> Using cache
 ---> bee10ffa6771
Step 6/9 : RUN CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o /go/bin/hello
 ---> Running in dd8ccad79109
Removing intermediate container dd8ccad79109
 ---> ef28c204ce8d
Step 7/9 : FROM scratch
 --->
Step 8/9 : COPY --from=builder /go/bin/hello /go/bin/hello
 ---> 4e593a70c739
Step 9/9 : ENTRYPOINT ["/go/bin/hello"]
 ---> Running in da2dd5db6ee7
Removing intermediate container da2dd5db6ee7
 ---> 40c6c33def8c
Successfully built 40c6c33def8c
Successfully tagged hello:latest
```

You can use `docker create` to create a non-running container of a Docker image,
and `docker cp` to copy the binary locally:

```sh
# Create the container
~> docker create --name hello hello:latest
2a3d2a5006620688898b1e22bc8a41c4ec10fbcd715e70b0589a8899d786d1a6

# Notice that the container isn't running but has a `status` of `created`
~> docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED         STATUS              PORTS               NAMES

~> docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                         PORTS               NAMES
e333d1d47662        hello:latest        "/go/bin/hello"          4 seconds ago       Created                                            hello

# Copy the binary
~> docker cp hello:/go/bin/hello .

# Run the binary
~> ./hello
Hello, world!

# Remove the container
~> docker rm -f hello
hello
```
