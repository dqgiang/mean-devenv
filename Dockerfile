FROM dqgiang/node_mongodb
MAINTAINER dqgiang

# Create the data directory for MongoDB
RUN mkdir -p /data/db
VOLUME /data/db

# Install MEAN.IO CLI
RUN npm install -g mean-cli

# Create 'dev' non-root user
RUN useradd -ms /bin/bash dev
# Create src directory for the user
RUN mkdir -p /home/dev/src
WORKDIR /home/dev/src

# Expose default port of MongoDB & Node from the container to the host
EXPOSE 27017
# Expose default HTTP interface port of MongoDB
EXPOSE 28017
EXPOSE 3000

# Start MongoDB and a terminal session on startup
ENV MONGOD_START "mongod --fork --logpath /var/log/mongodb.log --logappend --smallfiles --rest"
ENTRYPOINT ["/bin/sh", "-c", "$MONGOD_START && su dev && /bin/bash"]
