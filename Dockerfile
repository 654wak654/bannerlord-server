FROM debian:11

# Label source repo
LABEL org.opencontainers.image.source=https://github.com/654wak654/bannerlord-server

# Set workdir
WORKDIR /usr/games

# Set wine parameters
ENV WINEARCH="win32"
ENV WINEPREFIX=/root/wine

# Expose default port
EXPOSE 7210

# Run install script
COPY install.sh .
RUN chmod +x install.sh
RUN ["/bin/bash", "-c", "./install.sh"]

# Set steamcmd as a volume so data is not lost on container restart
VOLUME /steamcmd

# Prep launch script
COPY launch.sh .
RUN chmod +x launch.sh

CMD ["/bin/bash", "-c", "./launch.sh"]
