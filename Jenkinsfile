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
      parallel {
        stage('Testing A') {
          steps {
            sh 'ls -la'
          }
        }

        stage('Testing B') {
          steps {
            sh '''sleep 10
echo done.'''
          }
        }

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