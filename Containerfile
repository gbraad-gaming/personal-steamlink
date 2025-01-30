ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/rdesktop"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

USER root

RUN dnf install -y \
        flatpak \
    && dnf clean all \
    && rm -rf /var/cache/yum

RUN flatpak remote-add --if-not-exists \
        flathub https://dl.flathub.org/repo/flathub.flatpakrepo \
    && flatpak install --assumeyes \
        flathub com.valvesoftware.SteamLink

USER gbraad

RUN echo "exec flatpak run com.valvesoftware.SteamLink" >> $HOME/.config/i3/config

# ensure to become root for systemd
USER root
#ENTRYPOINT ["/sbin/init"]
