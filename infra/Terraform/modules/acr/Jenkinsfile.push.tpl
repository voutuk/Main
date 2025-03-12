pipeline {
    agent {
        label 'az-plug' 
    }

    options {
        ansiColor('xterm')
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    stages {
        stage('🔧 Setup Environment') {
            steps {
                sh '''
                    which az || {
                        echo "Installing Azure CLI..."
                        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
                        echo "Azure CLI installed successfully"
                    }
                '''
            }
        }
        
        stage('🔍 Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/voutuk/OLX_Dyplom_ADM'
            }
        }

        stage('🔍 Azure Login') {
            steps {
                azureCLI principalCredentialId: 'az-service-principal', commands: [
                    [script: "echo 'Successfully logged in to Azure'"]
                ]
            }
        }

        stage('🚀 Build Frontend prod version') {
            steps {
                azureCLI principalCredentialId: 'az-service-principal', commands: [
                    [script: "az acr build --registry ${ACR_NAME} --resource-group ${RESOURCE_GROUP_NAME} --image olx-client:latest --file ./OLX.Frontend/Dockerfile ./OLX.Frontend/"]
                ]
            }
        }

        stage('🚀 Build Backend prod version') {
            steps {
                azureCLI principalCredentialId: 'az-service-principal', commands: [
                    [script: "az acr build --registry ${ACR_NAME} --resource-group ${RESOURCE_GROUP_NAME} --image olx-api:latest --file ./OLX.API/Dockerfile ./OLX.API/"]
                ]
            }
        }
    }

    post {
        always {
            azureCLI principalCredentialId: 'az-service-principal', commands: [
                [script: "echo 'Logging out from Azure'"]
            ]
            cleanWs()
        }
    }
}