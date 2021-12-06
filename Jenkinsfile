pipeline {
    agent { node { label 'da-khoma-app' } }
    parameters {
      string(name: 'NUM_BUILD_VERSION', defaultValue: 'latest')
    }
    triggers {
        cron('03 08 * * 1-5')
    }
    stages {
        stage('Build-version') {
             when {
              environment name: 'NUM_BUILD_VERSION', value: 'latest'
             }
             steps {
                withCredentials([usernamePassword(credentialsId: 'jenkins-accsses-khoma', passwordVariable: 'JENKINS_PASS', usernameVariable: 'JENKINS_USER')]) {
                   script {
                       env.BUILD_VERSION = sh ( script: 'wget --auth-no-challenge --user=${JENKINS_PASS} --password=${JENKINS_USER} http://10.124.43.110:8080/job/deploy-petclinic/lastSuccessfulBuild/buildNumber',  returnStdout: true ).trim()
                   }
                }
             }
        }     
	    stage('Deploy-db') {
	    	agent { node { label 'da-khoma-db' } }
	      steps {
	      	   sh 'docker stop mysqlserver && docker rm mysqlserver && docker network rm mysqlnet && docker volume rm mysql_config && docker volume rm mysql_data'
	           sh 'docker volume create mysql_data'
               sh 'docker volume create mysql_config'
               sh 'docker network create mysqlnet'
               sh '''
               docker run -it -d -v mysql_data:/var/lib/mysql \
			   -v mysql_config:/etc/mysql/conf.d \
               --network mysqlnet \
               --name mysqlserver \
               -e MYSQL_USER=petclinic -e MYSQL_PASSWORD=petclinic \
               -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=petclinic \
               -p 3306:3306 mysql:8.0.23
               '''
			}
	    }	    
	    stage('Deploy-app') {
	    	agent { node { label 'da-khoma-app' } }
	      steps {
              withCredentials([string(credentialsId: '6cb8f73753db', variable: 'dockerpwd')]) {
                 sh "docker login -u 6cb8f73753db -p ${dockerpwd}"
              }
              sh 'docker pull 6cb8f73753db/petclinic'
              sh '''
              docker run -it --rm -d \
              --name springboot-server \
              --network mysqlnet \
              -e MYSQL_URL=jdbc:mysql://mysqlserver/petclinic \
              -p 8080:8080 petclinic
              '''
         }
       }
	}
}
