pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo "Start of Stage Systemd"
                sh "sudo su"
                sh 'cp ./systemd/petclinic.service /etc/systemd/system/'
                sh "systemctl daemon-reload"
                sh "systemctl start petclinic.service"
                sh "systemctl enable petclinic"
                sh "systemctl status petclinic"
                echo "---Systemd petclinic.service already run---"
            }
        }
    }
}
