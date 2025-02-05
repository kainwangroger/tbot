pipeline {
    agent any

    environment {
        BOT_TOKEN = credentials('telegram-bot-token')
    }

     stage('Initialize') {
        steps {
            script {
                dockerImage.inside {
                    sh 'make venv && make install'
                }
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


    stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("qrgram")
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
