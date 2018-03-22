MPLABX_VERSION := 4.15
XC_TOOL_SUITE  := xc8
XC_VERSION     := 1.45
PROJECT_DIR    := $(shell readlink -f ~/MPLABXProjects/)

IMAGE_NAME      = mplabx
USERID          = $(shell id -u)
GROUPID         = $(shell id -g)

DOCKER_ARGS    += --build-arg DEBIAN_FRONTEND=noninteractive
DOCKER_ARGS    += --build-arg MPLABX_VERSION=$(MPLABX_VERSION)
DOCKER_ARGS    += --build-arg XC_TOOL_SUITE=$(XC_TOOL_SUITE)
DOCKER_ARGS    += --build-arg XC_VERSION=$(XC_VERSION)


V :=

.PHONY: clean help build-container mplabx

all: build-container

build-container:
	$(V) docker build $(DOCKER_ARGS) -t thb/$(IMAGE_NAME):$(MPLABX_VERSION) .

rebuild-container: DOCKER_ARGS += --no-cache
rebuild-container: build-container

mplabx: build-container
	$(V) xhost local:root

	$(V) -docker run \
		--rm \
		--env DISPLAY=$(DISPLAY) \
		--env USER=$(USER) \
		--env USERID=$(USERID) \
		--env GROUPID=$(GROUPID) \
		--mount type=bind,src=/tmp/.X11-unix,dst=/tmp/.X11-unix \
		--mount type=volume,src=mplabx-$(MPLABX_VERSION)-$(USER),dst=/home/$(USER)/ \
		--mount type=bind,src=$(PWD)/src/,dst=/home/$(USER)/MPLABXProjects/$(shell basename $(PWD)) \
		thb/$(IMAGE_NAME):$(MPLABX_VERSION)
	$(V) xhost -local:root

clean:
	$(V) docker rmi thb/$(IMAGE_NAME):$(MPLABX_VERSION)
