# rpi-registry

docker registry v2 image for Raspberry Pi, based on the scratch image. The rest is taken from the official registry image.

## Prequisites

For Ubuntu 16.04 (Xenial), you need the following packages installed:

    apt install -y golang-go docker.io

## Usage

    # Build the image (depending on your Go distribution, you might have to use `sudo` -- see below)
    GOPATH=$HOME/.golang make
    
    # Test the image
    make test
    
    # Push it to Docker Hub
    make push
    
    # Cleanup
    make clean

## Operation

see: https://docs.docker.com/registry/deploying/, with the caveat that this registry expects a `/data` volume instead of the usual `/var/lib/registry` path.

## Statically linking the server binary

In order to build a statically linked `registry` binary, the `Makefile` sets `CGO_ENABLED=0`. If you're on Ubuntu 16.04 Xenial (`armhf`) and using the Go runtime that comes with it, Go will need to build a number of `.a` files inside `/usr/lib/go-1.6` the first time this is built (hence the need to use `sudo`), in order to have a statically linkable standard library.

These libraries will be re-used the next time you need to generate a statically linked binary.

# License

The MIT License (MIT)

Copyright (c) 2016 Rui Carmo, based on work originally done by cblomart

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
