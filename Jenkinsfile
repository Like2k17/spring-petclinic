pipeline {
	agent { node { label 'node-app' } }
	environment {
	   DOCKERHUB_CREDENTIALS = credentials('6cb8f73753db-dockerhub')
	}
	stages {
	   stage('Build Docker Image') {
	      steps {
	         checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-ssh-key', url: 'git@github.com:Like2k17/spring-petclinic.git']]])
	         echo "Start of Build Docker Image"
             echo "Building......."
             sh 'docker build -t petclinic .'
	      }
	   }
		stage('Push Docker Image') {
	      steps {
	         echo "Push of Build Docker Image"
             echo "Pushing......."
             withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
                sh "docker login -u 6cb8f73753db -p ${dockerHubPwd}"
             }
             sh 'docker push 6cb8f73753db/petclinic'
	      }
	   }
	}
	post {
        always {
            archiveArtifacts artifacts: '**/*.jar', onlyIfSuccessful: true
}
