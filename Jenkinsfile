pipeline {
    agent any

    environment {
        BOT_TOKEN = credentials('telegram-bot-token')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/htagcours/tbot.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("qrgram")
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'pytest tests'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    dockerImage.run('-d --name qrgram-bot')
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}