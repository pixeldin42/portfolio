pipeline {
    agent any

    tools {
        nodejs "node18"
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
                script {
                    if (isUnix()) {
                        sh 'npm install || echo "No npm packages to install"'
                        sh 'npm run build || echo "No build script found"'
                    } else {
                        bat 'npm install || echo No npm packages to install'
                        bat 'npm run build || echo No build script found'
                    }
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    if (isUnix()) {
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                            sh '''
                            echo "$PASS" | docker login -u "$USER" --password-stdin
                            docker build -t $IMAGE_NAME:latest .
                            docker push $IMAGE_NAME:latest
                            docker logout
                            '''
                        }
                    } else {
                        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                            bat """
                            echo %PASS% | docker login -u %USER% --password-stdin
                            docker build -t %IMAGE_NAME%:latest .
                            docker push %IMAGE_NAME%:latest
                            docker logout
                            """
                        }
                    }
                }
            }
        }
    }
}
