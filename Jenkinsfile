pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-account') // ✅ Use correct Docker Hub credentials
        IMAGE_NAME = 'ruslan0688/simple-js-app-jenkins' // Change to your Docker Hub repo
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/rgusseinov/simple-js-app-jenkins'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                echo 'Logging in to Docker Hub...'
                sh '''
                    docker logout
                    echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                '''
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                echo 'Pushing image to Docker Hub...'
                sh 'docker push $IMAGE_NAME:latest'
            }
        }
    }

    post {
        success {
            echo '🚀 Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
}
