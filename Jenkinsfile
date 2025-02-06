pipeline {
    agent any

    environment {
        BOT_TOKEN = credentials('kr-tbot-env-file')
    //     SCANNER_HOME = tool 'Sonar-scanner'
    //     ADMIN_EMAIL = "hervlokossou@gmail.com"
    }

    stages {
        stage('Initialiser') {
            steps {
                script {
                    echo "Initialisation du pipeline"
                }
            }
        }

        stage ('Inject Env') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'kr-tbot-env-file', variable: 'ENV_FILE')]) {
                        sh "cat $ENV_FILE >> .env"
                    }
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
                    sh 'docker rm -f qrgram-bot-kr'
                    sh 'docker run -d --name qrgram-bot-kr qrgram-kr'
                }
            }
        }
    }
    

    post {
        always {
            echo 'This will always run'
            // cleanWs()
        }
    }
}
// pipeline {
//     agent any

//     options {
//         ansiColor('xterm')
//     }

//     environment {
//         BOT_TOKEN = credentials('telegram-bot-token')
//         SCANNER_HOME = tool 'Sonar-scanner'
//         ADMIN_EMAIL = "hervlokossou@gmail.com"
//     }

//     stages {
//         stage('Initialize') {
//             steps {
//                 script {
//                     sh 'make venv && make install'
//                 }
//             }
//         }
//         stage ('Inject Env') {
//             steps {
//                 script {
//                     withCredentials([file(credentialsId: 'tbot-env-file', variable: 'ENV_FILE')]) {
//                         sh "cat $ENV_FILE >> .env"
//                     }
//                 }
//             }
//         }
//         /*stage('SonarQube Code Quality Analysis') {
//             steps {
//                 withSonarQubeEnv(credentialsId: 'sonar-credentialsId', installationName: 'Sonar') {
//                      sh '''$SCANNER_HOME/bin/sonar-scanner \
//                      -Dsonar.projectKey=hervlokossou \
//                      -Dsonar.projectName=hervlokossou \
//                      -Dsonar.sources=. \
//                      -Dsonar.projectVersion=${BUILD_NUMBER}-${GIT_COMMIT_SHORT}'''
//                 }
//             }
//         }*/
//         stage('Run Tests') {
//             steps {
//                 script {
//                     sh 'make test'
//                 }
//             }
//         }
//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     sh 'make build'
//                 }
//             }
//         }
//         stage('Deploy') {
//             steps {
//                 script {
//                     sh 'make deploy'
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             echo 'This will always run'
//             //cleanWs()
//         }
//          success {
//             echo 'This will run only if successful'
//             emailext body: 'A Succes Test EMail', recipientProviders:
//             [[$class: 'DevelopersRecipientProvider'],
//             [$class: 'RequesterRecipientProvider']], subject: 'Test'
//          }
//          failure {
//             emailext body: 'A Failed Test EMail', recipientProviders:
//             [[$class: 'DevelopersRecipientProvider'],
//             [$class: 'RequesterRecipientProvider']], subject: 'Test'
//          }
//          unstable {
//              echo 'This will run only if the run was marked as unstable'
//          }
//          changed {
//              echo 'This will run only if the state of the Pipeline has changed'
//              echo 'For example, if the Pipeline was previously failing but is now successful'
//          }
//     }
// }