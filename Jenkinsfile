pipeline {
  agent any
  stages {
    stage('Buzz Build') {
      steps {
        echo 'build package'
        sh './mvn clean'
      }
    }

    stage('Unit') {
      steps {
        junit '.xml'
      }
    }

  }
}