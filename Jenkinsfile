pipeline {
    agent any
    environment { 
        registry = "kelvinbun22/belajar-cicd" 
        registryCredential = 'dockerHub' 
        dockerImage = '' 
        HOST = "10.0.1.5"
    }
    stages {
        stage ('Checkout Git'){
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/kelvinbun64/docker-build.git']]])
          }
        }
        stage ('Build Project'){
            steps{
                script{
                    sh 'cd /var/lib/jenkins/workspace/Deploy-Stage-Dev'
                    sh 'tar -zcvf project.tar.gz .'
                    sh 'sudo mv /var/lib/jenkins/workspace/Deploy-Stage-Dev/project.tar.gz /home/devops'
                }
            }
        }
        stage ('Deploy To Dev'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'ssh-to-server', variable: 'password')]) {
                        sh 'sshpass -p "$password" scp -o "StrictHostKeyChecking no" -r /home/devops/project.tar.gz devops@$HOST:/home/devops'
                        sh 'sudo rm -rf /home/devops/project.tar.gz'
                    }
                }
            }
        }
    }
}
