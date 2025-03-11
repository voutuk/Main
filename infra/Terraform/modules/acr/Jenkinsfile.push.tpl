pipeline {
    agent {
        label 'system-node' 
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
                git 'https://github.com/voutuk/OLX_Dyplom_ADM'
            }
        }

        stage('🔍 Azure Login') {
            steps {
                withCredentials([azureServicePrincipal('azure-credentials')]) {
                    azureCLI commands: [
                        [script: "echo 'Successfully logged in to Azure'"]
                    ]
                }
            }
        }

        stage('🚀 Build Frontend prod version') {
            steps {
                azureCLI commands: [
                    [script: "az acr build --registry ${ACR_NAME} --resource-group ${RESOURCE_GROUP_NAME} --image olx-client:latest --file ./OLX.Frontend/ ./OLX.Frontend/"]
                ]
            }
        }

        stage('🚀 Build Backend prod version') {
            steps {
                azureCLI commands: [
                    [script: "az acr build --registry ${ACR_NAME} --resource-group ${RESOURCE_GROUP_NAME} --image olx-api:latest --file ./OLX.API/ ./OLX.API/"]
                ]
            }
        }
    }

    post {
        always {
            azureCLI commands: [
                [script: "echo 'Logging out from Azure'"]
            ]
            cleanWs()
        }
    }
}