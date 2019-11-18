library identifier: "pipeline-library@v1.4",
retriever: modernSCM(
  [
    $class: "GitSCMSource",
    remote: "https://github.com/redhat-cop/pipeline-library.git"
  ]
)

openshift.withCluster() {
  env.NAMESPACE = openshift.project()
  env.APP_NAME = "${JOB_NAME}".replaceAll(/-build.*/, '')
  echo "Starting Pipeline for ${APP_NAME}..."
  env.BUILD = "${env.NAMESPACE}"
  env.BUILD_CONFIG = "hello-chris-build"
}

pipeline {
  agent {
    label 'nodejs'
  }

  stages {

    stage('Build Container Image'){
      steps {
        // Copy the resulting artifacts into common directory
        sh """
          mkdir oc-build
          ls
          pwd
          cp ./* ./oc-build 2>/dev/null || :
        """
        binaryBuild(projectName: env.BUILD, buildConfigName: env.BUILD_CONFIG, buildFromPath: "oc-build")
      }
    }
  }
}
