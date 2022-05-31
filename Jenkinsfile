pipeline {
  agent any
  stages {
    stage('Buzz Build') {
      steps {
        echo 'build package'
      }
    }

    stage('Unit') {
      steps {
        junit '.xml'
      }
    }

  }
}