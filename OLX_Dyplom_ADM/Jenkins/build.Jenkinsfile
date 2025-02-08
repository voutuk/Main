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
                        // Tag as latest as well
                        sh "docker tag ${FRONTEND_IMAGE}:${BUILD_NUMBER} ${FRONTEND_IMAGE}:latest"
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
                        // Tag as latest as well
                        sh "docker tag ${BACKEND_IMAGE}:${BUILD_NUMBER} ${BACKEND_IMAGE}:latest"
                    }
                }
            }
        }
        stage('🔍 Verify Images') {
            steps {
                script {
                    sh """
                        echo "Checking for required images..."
                        docker images | grep ${FRONTEND_IMAGE}
                        docker images | grep ${BACKEND_IMAGE}
                    """
                }
            }
        }
        stage('🚀 Docker UP') {
            steps {
                script {
                    sh """
                        docker image inspect ${FRONTEND_IMAGE}:${BUILD_NUMBER}
                        docker image inspect ${BACKEND_IMAGE}:${BUILD_NUMBER}
                        
                        FRONTEND_IMAGE=${FRONTEND_IMAGE} \
                        BACKEND_IMAGE=${BACKEND_IMAGE} \
                        BUILD_NUMBER=${BUILD_NUMBER} \
                        docker compose -f docker-compose.yml up -d
                        
                        docker ps
                    """
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
            //sh 'docker compose -f docker-compose.yml down || true'
            //sh '''
            //    docker system prune -f
            //    docker volume prune -f
            //'''
        }
    }
}
