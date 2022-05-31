pipeline {
  agent any
  stages {
    stage('Buzz Build') {
      steps {
        echo 'build package'
        sh './mvnw clean'
      }
    }

    stage('Unit') {
      steps {
        junit '.xml'
      }
    }

  }
}