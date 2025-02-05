pipeline {
    agent any

    environment {
        BOT_TOKEN = credentials('telegram-bot-token')
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
                        sh 'make test'
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