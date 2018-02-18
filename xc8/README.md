Docker XC8
==========

Microchip [XC8](https://www.microchip.com/mplab/compilers) compiler
Dockerfile.


This image is intended to be used from command line. Its default behaviour is
to call the `make` command.


Building the image
------------------

To build this image simply type `make` into this directory. If you need to
customize _XC8_ version, adjust the `XC8_VERSION` variable _i.e._:
```
make XC8_VERSION=1.35
```

If you need to force rebuild use `make rebuild-image` which will rebuild
image from scratch.

To fully remove this image from your system enter `make clean`.


Usage in Makefile
-----------------

To easily compile your embedded project, adapt the following lines to
your own project Makefile.

```
USER        := $(USER)
USERID      := $(shell id -u)
GROUPID     := $(shell id -g)
XC8_VERSION := 1.44


$(TARGET):
	docker run --rm \
		--env USER=$(USER) \
		--env USERID=$(USERID) \
		--env GROUPID=$(GROUPID) \
		--mount type=bind,src=$(PWD)/$(@D)/,dst=/src/ \
		thb/xc8:$(XC8_VERSION)

```

Then run your usual `make` command. Adjust the environment variables and the
source path as needed.
