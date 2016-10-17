# rpi-registry

[![Docker Stars](https://img.shields.io/docker/stars/rcarmo/rpi-registry.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/rcarmo/rpi-registry.svg)][hub]

[hub]: https://hub.docker.com/r/rcarmo/rpi-registry/

Docker registry v2 image for Raspberry Pi, roughly 20MB in size and based on a statically compiled ARM binary.

## Usage

See: https://docs.docker.com/registry/deploying/, with the caveat that this registry expects a `/data` volume instead of the usual `/var/lib/registry` path. If you're OK with running an insecure registry for testing, this is the minimum required:

    docker run -d --restart=unless-stopped -p 5000:5000 -v /mnt/registry:/data rcarmo/rpi-registry

I use a Raspberry Pi as front-end to my NAS, mounting `/mnt/registry` in  `fstab` like so:

    //nas/registry /mnt/registry cifs guest,uid=1000,iocharset=utf8  0  0


## TODO

* [ ] SSL setup and docs
* [x] Minimal usage docs
* [x] Update to Go 1.6 and generate statically linked binary

## Build Prequisites

For Ubuntu 16.04 (Xenial), you need the following packages installed:

    apt install -y golang-go docker.io

## Build Steps

    # Build the image (depending on your Go distribution, you might have to use `sudo` -- see below)
    GOPATH=$HOME/.golang make
    
    # Test the image
    make test
    
    # Push it to Docker Hub
    make push
    
    # Cleanup
    make clean


## Build Notes

In order to build a statically linked `registry` binary, the `Makefile` sets `CGO_ENABLED=0`. If you're on Ubuntu 16.04 Xenial (`armhf`) and using the Go runtime that comes with it, Go will need to build a number of `.a` files inside `/usr/lib/go-1.6` the first time this is built (hence the need to use `sudo`), in order to have a statically linkable standard library.
