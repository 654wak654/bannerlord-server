FROM debian:11

# Label source repo
LABEL org.opencontainers.image.source=https://github.com/654wak654/bannerlord-server

# Set workdir
WORKDIR /usr/games

# Run install script with bash
COPY install.sh .
RUN ["/bin/bash", "-c", "./install.sh"]

# CMD [ "npm", "start" ]
