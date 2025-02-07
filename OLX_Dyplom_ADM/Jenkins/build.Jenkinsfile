pipeline {
    agent any
    
    environment {
        FRONTEND_IMAGE = 'olx-client'
        BACKEND_IMAGE = 'olx-asp-api'
        DOCKER_BUILDKIT = '1'
    }
    
    options {
        ansiColor('xterm')
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    
    stages {
        stage('🔍 Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/voutuk/OLX_Dyplom_ADM',
                    credentialsId: 'github-credentials'
            }
        }
        
        stage('🔍 Warnings Check') {
            steps {
                script {
                    recordIssues(
                        tools: [
                            hadoLint(pattern: '**/Dockerfile')
                        ],
                        qualityGates: [[threshold: 5, type: 'TOTAL', unstable: true]],
                        healthy: 5,
                        unhealthy: 10
                    )
                }
            }
        }
        
        stage('🏗️ Build Frontend') {
            steps {
                script {
                    sh '''
                        echo "=== Starting Docker Build Frontend ==="
                        docker build \
                            --progress=plain \
                            --no-cache \
                            -t ${FRONTEND_IMAGE}:${BUILD_NUMBER} \
                            ./OLX.Frontend 2>&1 | tee build-front.log
                        echo "=== Build Frontend End ==="
                    '''
                }
            }
        }
        
        stage('🏗️ Build Backend') {
            steps {
                script {
                    sh '''
                        echo "=== Starting Docker Build Backend ==="
                        docker build \
                            --progress=plain \
                            --no-cache \
                            -t ${BACKEND_IMAGE}:${BUILD_NUMBER} \
                            ./OLX.API 2>&1 | tee build-back.log
                        echo "=== Build Backend End ==="
                    '''
                }
            }
        }
        
        stage('🚀 Docker UP') {
            steps {
                script {
                    sh '''
                        docker compose -f docker-compose.yml up -d
                        docker ps
                    '''
                }
            }
        }
        
        stage('🌐 Network Check') {
            steps {
                script {
                    sh '''
                        echo "Public IP:"
                        curl -s ifconfig.me
                        
                        echo "\nContainer Network Details:"
                        docker network ls
                        docker network inspect bridge
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
        }
        always {
            archiveArtifacts artifacts: '*.log', 
                            fingerprint: true
            
            sh 'docker compose -f docker-compose.yml down || true'
            
            cleanWs()
        }
    }
}