pipeline {
    environment {
        registryCredential = "dockerhub"
        registryRepository = "marlapativ"
        postgresqlImageName = "postgresql"
        postgresqlImageTag = "16.3.0-debian-12-r19"
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
        stage('build and push postgresql image') {
            steps {
                sh '''
                    docker buildx build \
                        --build-arg BASEIMAGETAG=$postgresqlImageTag \
                        --platform linux/amd64,linux/arm64 \
                        --builder multiarch \
                        -t $imageRepo/$postgresqlImageName:latest \
                        -t $imageRepo/$postgresqlImageName:$postgresqlImageTag \
                        -f Dockerfile.postgresql \
                        --push \
                        .
                '''
            }
        }
    }
}
