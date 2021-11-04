pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo "Start of Stage Systemd"
                sh 'sudo cp ./systemd/petclinic.service /etc/systemd/system/'
                sh "sudo systemctl daemon-reload"
                sh "sudo systemctl start petclinic.service"
                sh "sudo systemctl enable petclinic"
                sh "systemctl status petclinic"
                echo "---Systemd petclinic.service already run---"
            }
        }
    }
}
