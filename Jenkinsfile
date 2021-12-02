pipeline {
	agent { node { label 'da-khoma-app' } }
	environment {
	   DOCKERHUB_CREDENTIALS = credentials('6cb8f73753db-dockerhub')
	}
        tools {
                maven 'M3'
        }
    triggers {
        cron('03 08 * * 1-5')
    }
    stages {
       stage('Checkout') {
           
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'ssh-key', url: 'git@github.com:Like2k17/spring-petclinic.git']]])
           }
       }
       stage('SonarQube Analysis') {
          steps {
	    withSonarQubeEnv() {
	       sh "mvn clean verify sonar:sonar -Dsonar.projectKey=jenkins-sonar"
	    }
          }        
        }
	   stage('Login') {
	      steps {
             echo "Logining......."
             withCredentials([string(credentialsId: '6cb8f73753db', variable: 'dockerpwd')]) {
                sh "docker login -u 6cb8f73753db -p ${dockerpwd}"
             }
	      }
	   }
	   stage('Push') {
	      steps {
	          echo "Pushing......."
	          sh 'docker push 6cb8f73753db/petclinic'
	      }
	   }
	}
}
