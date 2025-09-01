FROM jenkins/jenkins:lts

# Switch to root
USER root

# Install Docker CLI (static binary, no apt-get)
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-24.0.9.tgz \
    | tar -xz -C /usr/local/bin --strip-components=1 docker/docker && \
    chmod +x /usr/local/bin/docker

# Install kubectl (latest stable)
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Create container-local kubeconfig
RUN mkdir -p /var/jenkins_home/kube && \
    cat <<EOF > /var/jenkins_home/kube/config
apiVersion: v1
kind: Config
clusters:
- name: my-cluster
  cluster:
    server: https://host.docker.internal:8443
    insecure-skip-tls-verify: true
contexts:
- name: my-context
  context:
    cluster: my-cluster
    user: jenkins
current-context: my-context
users:
- name: jenkins
  user:
    token: eyJhbGciOiJSUzI1NiIsImtpZCI6IlhGRWJBR1R3RVg0NktKRmhkci1WblFWNW5fTkFaeS1LMl9pX3ZaWlM1N0kifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNzU2NzIyNzU4LCJpYXQiOjE3NTY3MTkxNTgsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwianRpIjoiNjA2ZTg5ZjMtNjY2ZC00YzJhLWE5ODgtZjhmNDdjMzg0ZDUyIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJkZWZhdWx0Iiwic2VydmljZWFjY291bnQiOnsibmFtZSI6ImplbmtpbnMtc2EiLCJ1aWQiOiIwYzJiMWMwNy1kYjgxLTRkYzMtYjFmYy1iNTI0N2I4OTFiZDcifX0sIm5iZiI6MTc1NjcxOTE1OCwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmRlZmF1bHQ6amVua2lucy1zYSJ9.iYGNl7HMa9H_8zifj_izkixXX1AXkWH6U9nSRszBUdQ1rcMn31BO-xFCYmOw7JGpxeDLZLlaDL0zoKe--ewg0PYs8GVXEZrOx07gLzeXNBqDY6CQk6SbOmX61H4a7jIk9WjkR6bNLm7BV_Ve41VWysulaJitJPdF7GDQyRJtSsG36owuJAm2DhY5TzNYbgz88_LLdhuTjdOb9H_OykZKCYY1MUNdfjtfQmmceHFKev4otKR1a2UBvP7ZEOCGtnPBqKCrjWnWr-mreX240kW8lNcCSI8xx6Wb2UIfAPmvuK7dwzJ8clarnkG5e9TXBYPLHnWNIcKPh6HhlVush_eEMA
EOF

RUN chown -R jenkins:jenkins /var/jenkins_home/kube

# Switch back to Jenkins user
USER jenkins
