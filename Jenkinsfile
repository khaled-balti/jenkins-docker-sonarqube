pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-web-app:latest"
        DOCKER_HUB_IMAGE = "khaled122/my-web-app:latest"
        SONARQUBE = "sonarqube"
        SONAR_TOKEN = credentials('SONAR_TOKEN')
        DOCKER_HUB_CRED = credentials('DOCKER_HUB_CRED')
    }

    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'master',
                     url: 'https://github.com/khaled-balti/jenkins-docker-sonarqube.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE}") {
                    sh """
                        ${tool 'SonarScanner'}/bin/sonar-scanner \
                          -Dsonar.projectKey=my-frontend-app \
                          -Dsonar.sources=. \
                          -Dsonar.host.url=http://sonarqube:9000 \
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
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                """
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
