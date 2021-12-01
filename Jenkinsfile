pipeline {
	agent { node { label 'da-khoma-app' } }
	environment {
	   DOCKERHUB_CREDENTIALS = credentials('6cb8f73753db-dockerhub')
           DB_NAME = 'petclinic'
           DB_USER = 'petclinic'
           DB_PASS = 'petclinic'
           DB_HOST = '3.210.54.209:3306'
	}
    triggers {
        cron('03 08 * * 1-5')
    }
    stages {
       stage('Checkout') {
           steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'ssh-key', url: 'git@github.com:Like2k17/spring-petclinic.git']]])
           }
       }
        stage('Build-app & SonarQube analysis') {
            steps {
                  sh """ sed -i -e "s#localhost/petclinic#${DB_HOST}/${DB_NAME}#g" \
                                -e "s#MYSQL_USER:petclinic#MYSQL_USER:${DB_USER}#g" \
                                -e "s#MYSQL_PASS:petclinic#MYSQL_PASSWORD:${DB_PASS}#g" src/main/resources/application-mysql.properties """
	          withSonarQubeEnv(credentialsId: 'sonarqube-khoma', installationName: 'sonarqube-khoma') {
                     sh './mvnw clean package sonar:sonar'
	          }
	    }
	}
	stage("Quality-Gate") {
	   steps {
	      timeout(time: 2, unit: 'MINUTES') {
	         waitForQualityGate abortPipeline: true
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
