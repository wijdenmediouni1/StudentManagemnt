pipeline {
    agent any

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
    }

    options {
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checkout du code depuis GitHub'
                git branch: 'main',
                    url: 'https://github.com/wijdenmediouni1/StudentManagemnt.git',
                    credentialsId: 'github_token'
            }
        }

        stage('Clean') {
            steps {
                echo 'Nettoyage complet du dossier target'
                sh 'rm -rf target || true'
            }
        }

        stage('Build') {
            steps {
                echo 'Compilation et packaging (sans exécuter les tests)'
                // Maven sera exécuté dans le dossier contenant le pom.xml
                dir('.') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

       
    }

    post {
        success {
            echo 'Pipeline terminé avec succès !'
            emailext(
                subject: "Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "Le build a réussi !\nVoir les détails ici : ${env.BUILD_URL}",
                to: "wijden.mediouni@esprit.tn"
            )
        }
        failure {
            echo 'Pipeline échoué !'
            emailext(
                subject: "Build FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "Le build a échoué !\nVoir les détails ici : ${env.BUILD_URL}",
                to: "wijden.mediouni@esprit.tn"
            )
        }
        always {
            echo 'Fin du pipeline'
        }
    }
}
