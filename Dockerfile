# x11docker/mate  -- from mviereck forked - to build for arm platforms and compare with my 
# x11docker/lmde (which gives cinnamon desktop)
# 
# docker buildx build -t andrewufrank/x11docker-mate:v1 --platform linux/arm/v7,linux/arm64,linux/amd64  --push .

# Run Mate desktop in docker. 
# Use x11docker to run image. 
# Get x11docker from github: 
#   https://github.com/mviereck/x11docker 
#
# Examples: x11docker --desktop x11docker/mate
#           x11docker x11docker/mate caja
#
# Options:
# Persistent home folder stored on host with   --home
# Shared host file or folder with              --share PATH
# Hardware acceleration with option            --gpu
# Clipboard sharing with option                --clipboard
# ALSA sound support with option               --alsa
# Pulseaudio sound support with option         --pulseaudio
# Language setting with                        --lang [=$LANG]
# Printing over CUPS with                      --printer
# Webcam support with                          --webcam
#
# See x11docker --help for further options.

FROM debian:buster

RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      dbus-x11 \
      procps \
      psmisc && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      xdg-utils \
      xdg-user-dirs \
      menu-xdg \
      mime-support \
      desktop-file-utils && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      mesa-utils \
      mesa-utils-extra \
      libxv1

# Language/locale settings
#   replace en_US by your desired locale setting, 
#   for example de_DE for german.
ENV LANG en_US.UTF-8
RUN echo $LANG UTF-8 > /etc/locale.gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      locales && \
    update-locale --reset LANG=$LANG

# Mate desktop
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      mate-desktop-environment-core && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      fortunes \
      mate-applets \
      mate-notification-daemon \
      mate-system-monitor \
      mate-utils

CMD ["mate-session"]

