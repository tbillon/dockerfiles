Docker XC8
==========

Microchip [MPLAB X IDE](https://www.microchip.com/mplab/mplab-x-ide)
Dockerfile.

This image along with the `Makefile` snippet will allow easy usage of the
Microchip MPLAB X IDE without ruining your system. It'll try to detect most of
its requirements from your environment.


Building the image
------------------

To build this image simply type `make` in this directory. You can change the
MPLAB version by adjusting the `XC8_VERSION` variable.

The image inherit from the [XC8]() image and can easily be adapted to the other
family compilers by setting the two variables `XC_TOOL_SUITE` and `XC_VERSION`.

If you need to force rebuild use `make rebuild-image` which will rebuild
image from scratch.

To fully remove this image from your system enter `make clean`.


Usage in Makefile
-----------------

Add the following snippet to your `Makefile`:
```
USER           := $(USER)
USERID         := $(shell id -u)
GROUPID        := $(shell id -g)
MPLABX_VERSION := 4.05

debug:
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
		thb/mplabx:$(MPLABX_VERSION)
	$(V) xhost -local:root
```
Then just enter `make debug` in your project directory.

A dedicated Docker volume is created to receive all the files created by the
IDE. Try to keep this volume intact from start to start as it'll greatly speed
up the program start-up. You can also use it for multiple projects.

The current directory will automatically be mounted into the image's
`~/MPLABXProjects/` as it is the IDE default projects directory.
