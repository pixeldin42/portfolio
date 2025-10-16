pipeline {
    agent any

    tools {
        nodejs "nodejs-latest"
    }

    environment {
        DOCKERHUB_USER = "pixeldin42"
        IMAGE_NAME = "pixeldin42/portfolio-site"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/pixeldin42/portfolio.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install || echo "No npm packages to install"'
                sh 'npm run build || echo "No build script found, skipping build step"'
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    echo "$PASS" | docker login -u "$USER" --password-stdin
                    docker build -t $IMAGE_NAME:latest .
                    docker push $IMAGE_NAME:latest
                    docker logout
                    '''
                }
            }
        }
    }
}
