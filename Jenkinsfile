pipeline {
    agent { node { label 'node-app' } }
    tools {
        // Install the Maven version configured as "M3"
        maven "M3"
    }
    stages {
        stage('Build') {
            steps {
                echo "Start of Stage Build"
                echo "Building......."
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-ssh-key', url: 'git@github.com:Like2k17/spring-petclinic.git']]])
                sh "./mvnw package"
            }
        }
        stage('Deploy') {
            steps {
                echo "Start of Stage Deploy"
                echo "Deploying......."
                script{
                    withEnv(['JENKINS_NODE_COOKIE=dontkill']) {
                        sh "nohup java -jar target/*.jar &"
                echo "End of Stage Deploy"
            
                    }
                }    
            }
        }
        stage('Systemd') {
            steps {
                echo "Start of Stage Systemd"
                echo "Create petclinic.service......."
                sh 'sudo cp ./systemd/petclinic.service /etc/systemd/system/'
                sh "sudo systemctl daemon-reload | sudo systemctl start petclinic.service | sudo systemctl enable petclinic | sudo systemctl restart petclinic"
                sh "systemctl status petclinic"
                echo "---Systemd already run---"
            }
        }
    }
}
