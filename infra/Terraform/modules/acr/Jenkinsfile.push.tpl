pipeline {
    agent {
        label 'az-plug' 
    }
    
    environment {
        DISCORD_WEBHOOK = credentials('discord-webhook')
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
                node('az-plug') {
                    sh '''
                        which az || {
                            echo "Installing Azure CLI..."
                            curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
                            echo "Azure CLI installed successfully"
                        }
                    '''
                }
            }
        }

        stage('🔍 USE ') {
            steps {
                node('az-plug') {
                    step([$class: 'GitHubCommitStatusSetter',
                     statusResultSource: [$class: 'ConditionalStatusResultSource',
                     results: [[$class: 'AnyBuildResult', 
                               message: 'Pipeline Proceeded', 
                               state: 'PENDING']]]])
                    sh '''
                        which az || {
                            echo "Installing Azure CLI..."
                            curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
                            echo "Azure CLI installed successfully"
                        }
                    '''
                    sh 'ls -la'
                    git url: 'https://github.com/voutuk/OLX_Dyplom_ADM', branch: 'main'
                    withCredentials([azureServicePrincipal('az-service-principal')]) {
                        sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                        sh 'az acr build --registry ${ACR_NAME} --resource-group ${RESOURCE_GROUP_NAME} --image olx-client:latest --file ./OLX.Frontend/Dockerfile ./OLX.Frontend/'
                        sh 'az acr build --registry ${ACR_NAME} --resource-group ${RESOURCE_GROUP_NAME} --image olx-api:latest --file ./OLX.API/Dockerfile ./OLX.API/'
                    }
                }
            }
        }  
    }

    post {
        success {
            discordSend(
                description: "✅ Build успішно завершено!",
                footer: "Jen / BublikDEV",
                link: env.BUILD_URL,
                result: "🟢 SUCCESS",
                title: env.JOB_NAME,
                webhookURL: DISCORD_WEBHOOK
            )
            step([$class: 'GitHubCommitStatusSetter',
                         statusResultSource: [$class: 'ConditionalStatusResultSource',
                         results: [[$class: 'AnyBuildResult', 
                                   message: 'Deployed', 
                                   state: 'SUCCESS']]]])
        }
        failure {
            discordSend(
                description: "❌ Build провалився!",
                footer: "Jen / BublikDEV",
                link: env.BUILD_URL,
                result: "🔴 FAILURE",
                title: env.JOB_NAME,
                webhookURL: DISCORD_WEBHOOK
            )
            step([$class: 'GitHubCommitStatusSetter',
                         statusResultSource: [$class: 'ConditionalStatusResultSource',
                         results: [[$class: 'AnyBuildResult', 
                                   message: 'Failed', 
                                   state: 'FAILURE']]]])
        }
        unstable {
            discordSend(
                description: "⚠️ Build нестабільний!",
                footer: "Jen / BublikDEV",
                link: env.BUILD_URL,
                result: "🟡 UNSTABLE",
                title: env.JOB_NAME,
                webhookURL: DISCORD_WEBHOOK
            )
            step([$class: 'GitHubCommitStatusSetter',
                         statusResultSource: [$class: 'ConditionalStatusResultSource',
                         results: [[$class: 'AnyBuildResult', 
                                   message: 'Unstable',
                                   state: 'FAILURE']]]]) 
        }
        always {
            cleanWs()
        }
    }
}