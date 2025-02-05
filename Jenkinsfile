pipeline {
    agent any

    environment {
        BOT_TOKEN = credentials('telegram-bot-token')
    }

    stages {
        stage('Initialiser') {
            steps {
                script {
                    echo "Initialisation du pipeline"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("qrgram")
                }
            }
        }

        stage('Exécuter les tests') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'pytest tests'
                    }
                }
            }
        }

        stage('Déployer') {
            steps {
                script {
                    sh 'docker run -d --name qrgram-bot qrgram'
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
