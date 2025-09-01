FROM jenkins/jenkins:lts

# Switch to root
USER root

# Install Docker CLI (static binary, no apt-get)
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-24.0.9.tgz \
    | tar -xz -C /usr/local/bin --strip-components=1 docker/docker && \
    chmod +x /usr/local/bin/docker

# Install kubectl (latest stable)
# RUN curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
#     chmod +x kubectl && mv kubectl /usr/local/bin/

# Switch back to Jenkins user
USER jenkins
