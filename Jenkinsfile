node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "website-demo"
    // registryHost = "192.168.19.5:5000/"
    imageName = "${env.registry_host}/${appName}:${tag}"
    env.BUILDIMG=imageName

    stage "Build"
    
        sh "docker build -t ${imageName} ."
    
    stage "Push"

        sh "docker push ${imageName}"
    stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh "./gradlew sonarqube"
                }
            }
        }
    stage("Quality gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
    }
    stage "Deploy"
        sh "sed -i s/xxx/$tag/g k8s/deployment.yaml"
	sh "kubectl ${env.token_kube} apply -f k8s/deployment.yaml"
}
