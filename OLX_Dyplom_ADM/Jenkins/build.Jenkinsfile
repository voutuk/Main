pipeline {
    agent {
        label 'docker-agent' 
    }
    
    environment {
        FRONTEND_IMAGE = 'olx-client'
        BACKEND_IMAGE = 'olx-asp-api'
        DOCKER_BUILDKIT = '1'
        DOCKER_HOST = 'unix:///var/run/docker.sock'
    }
    
    options {
        ansiColor('xterm')
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    
    stages {
        stage('🔍 Check Environment') {
            steps {
                script {
                    sh 'docker version'
                    sh 'docker compose version'
                }
            }
        }
        
        stage('🔍 Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/voutuk/OLX_Dyplom_ADM'
            }
        }
        
        stage('🏗️ Build Frontend') {
            steps {
                script {
                    docker.withRegistry('', '') {
                        def frontendImage = docker.build(
                            "${FRONTEND_IMAGE}:${BUILD_NUMBER}",
                            "--no-cache --progress=plain ./OLX.Frontend"
                        )
                        env.FRONTEND_IMAGE_ID = frontendImage.id
                    }
                }
            }
        }
        
        stage('🏗️ Build Backend') {
            steps {
                script {
                    docker.withRegistry('', '') {
                        def backendImage = docker.build(
                            "${BACKEND_IMAGE}:${BUILD_NUMBER}",
                            "--no-cache --progress=plain ./OLX.API"
                        )
                        env.BACKEND_IMAGE_ID = backendImage.id
                    }
                }
            }
        }
        
        stage('🚀 Docker UP') {
            steps {
                script {
                    sh """
                        docker image inspect ${FRONTEND_IMAGE}:${BUILD_NUMBER}
                        docker image inspect ${BACKEND_IMAGE}:${BUILD_NUMBER}
                    """

                    sh 'docker compose -f docker-compose.yml up -d'
                    sh 'docker ps'
                }
            }
        }
        
        stage('🌐 Network Check') {
            steps {
                script {
                    sh '''
                        echo "Agent Public IP:"
                        curl -s ifconfig.me
                        
                        echo "\nContainer Network Details:"
                        docker network ls
                        docker network inspect bridge
                        
                        echo "\nRunning Containers:"
                        docker ps -a
                    '''
                }
            }
        }
    }
    
    post {
        success {
            echo '🎉 Pipeline completed successfully!'
        }
        failure {
            echo '💥 Pipeline failed'
            sh 'docker compose -f docker-compose.yml down || true'
            sh '''
                docker system prune -f
                docker volume prune -f
            '''
        }
        always {
            script {
                archiveArtifacts artifacts: '*.log', 
                    fingerprint: true
                //cleanWs()
            }
        }
    }
}