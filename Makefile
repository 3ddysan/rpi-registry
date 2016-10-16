DOCKER_IMAGE_VERSION=0.1.0
DOCKER_IMAGE_NAME=rcarmo/rpi-registry
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

bin:
	mkdir bin

$(GOPATH)/bin/registry:
	GOOS=linux GOARCH=arm  GOARM=5 go get github.com/docker/distribution/cmd/registry

build: $(GOPATH)/bin/registry bin
	cp $(GOPATH)/bin/registry ./bin/
	docker build -t $(DOCKER_IMAGE_NAME) .
	docker tag $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_NAME):latest
	docker tag $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_TAGNAME)

clean:
	rm -rf ./bin
	rm -rf $(GOPATH)/bin/registry

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm $(DOCKER_IMAGE_NAME) --version
