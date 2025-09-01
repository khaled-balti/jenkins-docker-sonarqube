FROM jenkins/jenkins:lts

# Switch to root
USER root

# Install Docker CLI (static binary, no apt-get)
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-24.0.9.tgz \
    | tar -xz -C /usr/local/bin --strip-components=1 docker/docker && \
    chmod +x /usr/local/bin/docker

    # Create docker group with same GID as host Docker group
ARG DOCKER_GID=999
RUN groupadd -g ${DOCKER_GID} docker || true \
    && usermod -aG docker jenkins
# Install kubectl
#RUN curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl" \
    #&& chmod +x kubectl && mv kubectl /usr/local/bin/

# Switch back to Jenkins user
USER jenkins
