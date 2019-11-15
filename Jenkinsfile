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
}

pipeline {
  agent {
    label 'nodejs'
  }

  stages {
    stage('Git Checkout') {
      steps {
        // Turn off Git's SSL cert check, uncomment if needed
        // sh 'git config --global http.sslVerify false'
        git url: "${APPLICATION_SOURCE_REPO}", branch: "${APPLICATION_SOURCE_REF}"
      }
    }

    stage('Build Container Image'){
      steps {
        // Copy the resulting artifacts into common directory
        sh """
          ls *
          cp -rfv ./* oc-build 2> /dev/null || echo "No \$t files"
        """
        binaryBuild(projectName: env.BUILD, buildConfigName: env.APP_NAME, buildFromPath: "oc-build")
      }
    }
  }
}
