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
        sh 'ls -la'
      }
    }

    stage('Environment') {
      steps {
        echo 'I am a ${BUZZ_NAME}'
      }
    }

  }
  environment {
    BUZZ_NAME = 'Worker Bee'
  }
}