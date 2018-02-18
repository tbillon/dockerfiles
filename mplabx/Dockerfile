ARG XC_TOOL_SUITE
ARG XC_VERSION
FROM thb/${XC_TOOL_SUITE}:${XC_VERSION}


ARG DEBIAN_FRONTEND
ARG MPLABX_VERSION

RUN dpkg --add-architecture i386 \
    && apt-get -q -y update \
    && apt-get -q -y --no-install-recommends install \
       libgtk2.0-0 \
       libxext6 \
       libxrender1 \
       libxtst6 \
       libxi6 \
       libx11-6:i386 \
       libxext6:i386
#     libxslt1.1



RUN mkdir -p /downloads/ \
    && curl -fL# -o MPLABX-v${MPLABX_VERSION}-linux-installer.tar \
    	 http://ww1.microchip.com/downloads/en/DeviceDoc/MPLABX-v${MPLABX_VERSION}-linux-installer.tar \
    && tar xf MPLABX-v${MPLABX_VERSION}-linux-installer.tar \
    && USER=root ./MPLABX-v${MPLABX_VERSION}-linux-installer.sh \
       --nox11 -- \
       --mode unattended \
       --unattendedmodeui none \
    && rm -rf /downloads/

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/mplab_ide"]
