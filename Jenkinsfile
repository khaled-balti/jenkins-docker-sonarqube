pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-web-app:latest"
        DOCKER_HUB_IMAGE = "khaled122/my-web-app:latest"
        SONARQUBE = "sonarqube"
        SONAR_TOKEN = credentials('SONAR_TOKEN')        // stored in Jenkins
        DOCKER_HUB_CRED = credentials('DOCKER_HUB_CRED') // stored in Jenkins
        KUBECONFIG = '/var/jenkins_home/kube/config'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/khaled-balti/jenkins-docker-sonarqube.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE}") {
                    sh """
                        ${tool 'SonarScanner'}/bin/sonar-scanner \
                          -Dsonar.projectKey=my-frontend-app \
                          -Dsonar.sources=. \
                          -Dsonar.host.url=http://localhost:9000 \
                          -Dsonar.login=${SONAR_TOKEN}
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'DOCKER_HUB_CRED') {
                        sh """
                            docker tag ${DOCKER_IMAGE} ${DOCKER_HUB_IMAGE}
                            docker push ${DOCKER_HUB_IMAGE}
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                    kubectl --kubeconfig=/var/jenkins_home/.kube/config apply --validate=false -f k8s/deployment.yml
                    kubectl --kubeconfig=/var/jenkins_home/.kube/config apply --validate=false -f k8s/service.yml
                """
            }
        }
    }
}
