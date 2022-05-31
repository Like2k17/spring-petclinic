pipeline {
  agent any
  stages {
    stage('Buzz Build') {
      steps {
        echo 'build package'
        sh './mvnw package'
      }
    }

    stage('Buzz Test') {
      steps {
        archiveArtifacts(artifacts: 'target/*.jar', fingerprint: true)
      }
    }

  }
}