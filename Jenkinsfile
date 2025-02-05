pipeline {
    agent any

    environment {
        BOT_TOKEN = credentials('telegram-bot-token')
    }


    stage('Initialize') {
        steps {
            script {
                    sh 'make venv && make install'
                }
            }
        }

    
    stage('Run Tests') {
        steps {
            script { 
                    sh 'make test'
                    }
                }
            }


    stage('Build Docker Image') {
        steps {
            script {
                sh 'make build'
                }
            }
        }

    stage('Deploy') {
        steps {
            script {
                sh 'make test'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
