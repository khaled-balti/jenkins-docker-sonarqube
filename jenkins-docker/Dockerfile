FROM jenkins/jenkins:lts

USER root

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-24.0.9.tgz \
    | tar -xz -C /usr/local/bin --strip-components=1 docker/docker && \
    chmod +x /usr/local/bin/docker

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Ensure kube folder exists (will mount local kubeconfig)
RUN mkdir -p /var/jenkins_home/.kube && \
    chown -R jenkins:jenkins /var/jenkins_home/.kube

USER jenkins

# Point Jenkins to kubeconfig
ENV KUBECONFIG=/var/jenkins_home/.kube/config
