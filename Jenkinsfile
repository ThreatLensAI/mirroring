pipeline {
    environment {
        registryCredential = 'dockerhub'
        registryRepository = "marlapativ"
    }
    agent any
    stages {
        stage('Setup Docker') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'password', usernameVariable: 'username')]) {
                        sh('docker login -u $username -p $password')
                    }
                }
            }
        }
        stage('Mirror Images') {
            steps {
                    sh '''
                        chmod +x mirror.sh
                        ./mirror.sh images-list.txt $registryRepository
                    '''
            }
        }
    }
}
