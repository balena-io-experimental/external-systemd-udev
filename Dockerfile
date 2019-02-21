FROM arm64v8/ros:kinetic-ros-base-xenial

###
# Installing sytstemd in the balena way
# https://www.balena.io/docs/reference/base-images/base-images/#installing-your-own-initsystem
###
ENV container docker
RUN apt-get update && apt-get install -y --no-install-recommends \
        systemd udev\
    && rm -rf /var/lib/apt/lists/*

# We never want these to run in a container
# Feel free to edit the list but this is the one we used
RUN systemctl mask \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    sys-kernel-config.mount \
    display-manager.service \
    getty@.service \
    systemd-logind.service \
    systemd-remount-fs.service \
    getty.target \
    graphical.target

COPY systemd/entry.sh /usr/bin/entry.sh
COPY systemd/balena.service /etc/systemd/system/balena.service

RUN systemctl enable /etc/systemd/system/balena.service

#VOLUME ["/sys/fs/cgroup"]
ENTRYPOINT ["/usr/bin/entry.sh"]
###
# End of install
###

###
# Actual application
###
ENV INITSYSTEM on
WORKDIR /usr/src/app

COPY start.sh .

CMD ./start.sh
