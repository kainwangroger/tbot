pipeline {
    agent any

    environment {
        BOT_TOKEN = credentials('telegram-bot-token')
        SCANNER_HOME = tool 'Sonar-scanner'
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    sh 'make venv && make install'
                }
            }
        }
        stage('Code Quality') {
            steps {
                steps {
                    withSonarQubeEnv(credentialsId: 'sonarqube', installationName: 'Sonar') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                         -Dsonar.projectKey=hervlokossou \
                         -Dsonar.projectName=tbot \
                         -Dsonar.host.url=http://15.237.5.155:9000 \
                         -Dsonar.sources=. \
                         -Dsonar.java.binaries=target/classes/ \
                         -Dsonar.exclusions=src/test/java/****/*.java \
                         -Dsonar.java.libraries=/var/lib/jenkins/.m2/**/*.jar \
                         -Dsonar.projectVersion=${BUILD_NUMBER}-${GIT_COMMIT_SHORT}
                        '''
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