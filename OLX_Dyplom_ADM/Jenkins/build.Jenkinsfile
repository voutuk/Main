pipeline {
    agent any
    options {
        ansiColor('xterm')
        timestamps()
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/voutuk/OLX_Dyplom_ADM'
            }
        }
        stage('Build Frontend') {
            steps {
                script {
                    sh '''
                        echo "=== Starting Docker Build Frontend ==="
                        DOCKER_BUILDKIT=1 docker build \
                            --progress=plain \
                            --no-cache \
                            -t olx-client ./OLX.Frontend 2>&1 | tee build-front.log
                        echo "=== Build Completed ==="
                    '''
                }
            }
        }

        stage('Build Backend') {
            steps {
                script {
                    sh '''
                        echo "=== Starting Docker Build Backend ==="
                        DOCKER_BUILDKIT=1 docker build \
                            --progress=plain \
                            --no-cache \
                            -t olx-asp-api ./OLX.API 2>&1 | tee build-back.log
                        echo "=== Build Completed ==="
                    '''
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                // Adjust file name/path if needed
                sh 'docker compose -f docker-compose.yml up -d'
            }
        }

        stage('Show Public IP') {
            steps {
                script {
                    echo "Public IP of this host:"
                    sh 'curl -s ifconfig.me'
                }
            }
        }

        stage('Finish') {
            steps {
                script {
                    echo "Pipeline completed successfully."
                    input message: "Pipeline completed successfully. Press Stop.", ok: "KILL"
                }
            }
        }

        stage('Docker Compose Stop') {
            steps {
                // Adjust file name/path if needed
                sh 'docker compose -f docker-compose.yml kill'
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'build-front.log', allowEmptyArchive: true
            archiveArtifacts artifacts: 'build-back.log', allowEmptyArchive: true
        }
    }
}