XC8_VERSION := 1.45
IMAGE_NAME  := xc8

DOCKER_ARGS += --build-arg DEBIAN_FRONTEND=noninteractive
DOCKER_ARGS += --build-arg XC8_VERSION=$(XC8_VERSION)


V := @


.PHONY: clean build-image rebuild-image

all: build-image

build-image:
	$(V) docker build $(DOCKER_ARGS) -t thb/$(IMAGE_NAME):$(XC8_VERSION) .

rebuild-image: DOCKER_ARGS += --no-cache
rebuild-image: build-image

clean:
	$(V) docker rmi thb/$(IMAGE_NAME):$(XC8_VERSION)
