pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo "---Start of Stage Systemd---"
                sh 'sudo cp ./systemd/petclinic.service /etc/systemd/system/'
                sh "sudo systemctl daemon-reload | sudo systemctl start petclinic.service | sudo systemctl enable petclinic | sudo systemctl restart petclinic"
                sh "systemctl status petclinic"
                echo "---Systemd petclinic.service already run---"
            }
        }
    }
}
