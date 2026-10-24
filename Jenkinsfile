pipeline {
    agent any
    environment {
        DOCKER_CREDS = 'dockerhub-credentials-id'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Choose image repository based on branch name
                    def imageName = (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') ? 
                                    'subbiahthevar/prod:latest' : 
                                    'subbiahthevar/react-app-dev:latest'
                    
                    echo "Building Docker image as ${imageName}..."
                    sh "docker build -t ${imageName} ."
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    def imageName = (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') ? 
                                    'subbiahthevar/prod:latest' : 
                                    'subbiahthevar/react-app-dev:latest'
                    
                    echo "Pushing ${imageName} to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: "${env.DOCKER_CREDS}", 
                                                      usernameVariable: 'DOCKER_USER', 
                                                      passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo '${DOCKER_PASS}' | docker login -u '${DOCKER_USER}' --password-stdin"
                        sh "docker push ${imageName}"
                    }
                }
            }
        }
    }
}
