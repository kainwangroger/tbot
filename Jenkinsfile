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
                    dockerImage = docker.build("qrgram-kr")
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
                    sh 'docker run -d --name qrgram-bot-kr qrgram-kr'
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
    // success {
    //     echo 'This will run only if successful'
    //     emailext body: 'A Succes Test EMail', recipientProviders:
    //     [[$class: 'DevelopersRecipientProvider'],
    //     [$class: 'RequesterRecipientProvider']], subject: 'Test'
    //     }
    // failure {
    //     emailext body: 'A Failed Test EMail', recipientProviders:
    //     [[$class: 'DevelopersRecipientProvider'],
    //     [$class: 'RequesterRecipientProvider']], subject: 'Test'
    //     }
    // unstable {
    //     echo 'This will run only if the run was marked as unstable'
    //      }
    // changed {
    //     echo 'This will run only if the state of the Pipeline has changed'
    //     echo 'For example, if the Pipeline was previously failing but is now successful'
    //      }
 