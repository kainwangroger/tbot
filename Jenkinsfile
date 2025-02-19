pipeline {
    agent any

    options {
        ansiColor('xterm')
    }

    environment {
        BOT_TOKEN = credentials('kr-tbot-env-file')
        // SCANNER_HOME = tool 'Sonar-scanner'
        // ADMIN_EMAIL = 'rogerboukar07@gmail.com'
        // ADMIN_EMAIL = 'rogerboukar07@gmail.com'
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    sh 'make venv && make install'
                }
            }
        }

        stage('Inject Env') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'kr-tbot-env-file', variable: 'ENV_FILE')]) {
                        sh "cat $ENV_FILE >> .env"
                    }
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
                    sh 'make deploy'
                    sh 'make deploy'
                }
            }
        }
    }

    post {
        always {
            echo 'This will always run'
            //cleanWs()
        }
    }
}