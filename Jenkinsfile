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
                git url: 'https://github.com/wijdenmediouni1/StudentManagemnt.git',
                    credentialsId: 'github_token'
            }
        }

        stage('Clean') {
            steps {
                echo 'Nettoyage complet du dossier target'
                sh 'rm -rf student-management/target || true'
            }
        }

        stage('Build') {
            steps {
                echo 'Compilation et packaging (sans exécuter les tests)'
                dir('student-management') {
                    sh 'ls -la'  // juste pour vérifier que pom.xml est là
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

    
    }

    post {
        success {
            echo 'Pipeline terminé avec succès !'
        }
        failure {
            echo 'Pipeline échoué !'
        }
    }
}
