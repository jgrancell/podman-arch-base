FROM docker.io/library/archlinux:base-20260614.0.544538
ENV LANG="en_US.UTF-8"


######################
## Base Image Setup ##
######################

## Sets up our local system properly.
COPY etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist

RUN sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen \
  && locale-gen

## Standardizing the base image to match our system configuration.
RUN pacman -Syu --noconfirm which git ripgrep \
  && groupadd -g 1000 arch \
  && useradd -m -u 1000 -g arch -s /usr/bin/bash arch \
  && rm -rf /var/cache/pacman/pkg/ \
  && rm -rf /var/lib/pacman/sync/

USER arch
WORKDIR /home/arch
ENV HOME="/home/arch"
ENV PATH="/home/arch/.local/bin:$PATH"

RUN mkdir -p "$HOME/.local/bin"
