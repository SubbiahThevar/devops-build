pipeline {
    agent any
    
    environment {
        // Your Docker Hub credential ID in Jenkins (we'll set this up next)
        DOCKER_HUB_CREDENTIALS = 'dockerhub-credentials-id'
        IMAGE_NAME = 'subbiahthevar/react-app-dev'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Pulls the latest code from your GitHub dev branch
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Logging into Docker Hub and pushing image..."
                    // Uses Jenkins credentials binding to log in securely without exposing passwords in logs
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", 
                                                      usernameVariable: 'DOCKER_USER', 
                                                      passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                        sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo "Pipeline completed successfully! Image pushed to Docker Hub."
        }
        failure {
            echo "Pipeline failed. Please check the logs above."
        }
    }
}