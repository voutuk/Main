pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Make sure to specify the branch or commit you need
                git branch: 'main', url: 'https://github.com/OlexKov/OLX_Dyplom.git'
            }
        }

        stage('Build Frontend') {
            steps {
                // Adjust path if actual directory differs
                sh 'docker build -t olx-client ./OLX.Frontend'
            }
        }

        stage('Build Backend') {
            steps {
                // Adjust path if actual directory differs
                sh 'docker build -t olx-asp-api ./OLX.API'
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
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}