# Base image
FROM postman/newman:5.3-alpine

# Set DNS
RUN echo 'nameserver 8.8.8.8' > /etc/resolv.conf && \
    echo 'nameserver 1.1.1.1' >> /etc/resolv.conf

# Update and install packages
RUN apk update && apk upgrade && \
    apk add --no-cache curl zip iputils && \
    npm install -g newman-reporter-csvallinone && \
    npm cache clean --force && \
    rm -rf /var/cache/apk/*

# Environment variables
ENV NODE_PATH=/usr/local/lib/node_modules

# Working directory
WORKDIR /etc/newman

# Entrypoint
ENTRYPOINT ["newman"]