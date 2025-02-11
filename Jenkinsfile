pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-account') // ✅ Docker Hub credentials
        IMAGE_NAME = 'ruslan0688/vtiger74-cicd' // Change to your Docker Hub repo
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/rgusseinov/simple-js-app-jenkins'
            }
        }

        stage('Extract Commit Hash') {
            steps {
                script {
                    COMMIT_HASH = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    APP_VERSION = "app_dev_${COMMIT_HASH}"
                    echo "Using version: $APP_VERSION"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image with tag: $APP_VERSION..."
                    sh """
                        docker build -t $IMAGE_NAME:$APP_VERSION -t $IMAGE_NAME:latest .
                    """
                }
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
                script {
                    echo "Pushing image with tags: $APP_VERSION, latest..."
                    sh """
                        docker push $IMAGE_NAME:$APP_VERSION
                        docker push $IMAGE_NAME:latest
                    """
                }
            }
        }
    }

    post {
        success {
            echo "🚀 Deployment Successful! Image pushed with version: $APP_VERSION"
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
}
