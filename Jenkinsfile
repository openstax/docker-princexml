@Library('pipeline-library') _

pipeline {
  agent { label 'docker' }
  stages {
    stage('Build') {
      steps {
        sh "docker build -t openstax/princexml:${GIT_COMMIT} ."
      }
    }
    stage('Publish Dev Container') {
      steps {
        // 'docker-registry' is defined in Jenkins under credentials
        withDockerRegistry([credentialsId: 'docker-registry', url: '']) {
          sh "docker push openstax/princexml:${GIT_COMMIT}"
        }
      }
    }
    stage('Publish Release') {
      when { buildingTag() }
      environment {
        release = getVersion()
      }
      steps {
        withDockerRegistry([credentialsId: 'docker-registry', url: '']) {
          sh "docker tag openstax/princexml:${GIT_COMMIT} openstax/princexml:${release}"
          sh "docker tag openstax/princexml:${GIT_COMMIT} openstax/princexml:latest"
          sh "docker push openstax/princexml:${release}"
          sh "docker push openstax/princexml:latest"
        }
      }
    }
  }
}
