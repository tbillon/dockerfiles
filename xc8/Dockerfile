FROM ubuntu:xenial


ARG DEBIAN_FRONTEND
ARG XC8_VERSION


RUN dpkg --add-architecture i386 \
    && apt-get -q -y update \
    && apt-get -q -y --no-install-recommends install \
        curl \
	make \
    	libc6:i386 \
	libstdc++6:i386 \
    	libexpat1:i386

RUN mkdir /downloads/ \
    && curl -fL# -o xc8-v${XC8_VERSION}-full-install-linux-installer.run \
    	 http://ww1.microchip.com/downloads/en/DeviceDoc/xc8-v${XC8_VERSION}-full-install-linux-installer.run \
    && chmod +x xc8-v${XC8_VERSION}-full-install-linux-installer.run \
    && ./xc8-v${XC8_VERSION}-full-install-linux-installer.run  \
       --mode unattended \
       --unattendedmodeui none \
       --netservername "" \
    && rm -rf /downloads/

COPY ./entrypoint.sh /
WORKDIR /src/
ENV PATH "$PATH:/opt/microchip/xc8/v${XC8_VERSION}/bin/"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["make"]
