pipeline {
    environment {
    registry = "innag21/capstone-app"
    registryCredential = 'docker-hub'
    }
    
    agent any
    stages {
        
        stage ('Cloning Git') {
            steps {
                git 'https://github.com/ig21/Udacity_ND_Cloud_DevOps_CapstoneP.git'
            }
        }

        stage ('Make-all') {
            steps {
                sh 'make all'
            }
        }

        stage ('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }

        stage('Building image') {
            steps {
                script {
                    sh 'docker build --tag=innag21/capstone-app .'
                }
            }
        }

        stage('Deploy Image') {
            steps {
                script {
                    withDockerRegistry([ credentialsId: "docker-hub", url: "" ]) {
                    sh 'docker push innag21/capstone-app'
                    }
                }
            }
        }

        stage ('Upload latest green deployment to AWS Loadbalancer') {
            steps {
               script {
                    withAWS(credentials: 'aws-credentials', region: 'us-east-1'){
                   // Latest
                   sh "aws eks --region us-east-1 update-kubeconfig --name nanocluster"
                   sh 'kubectl apply -f deploy/green.yml'
                  }
               }
            }
        }

        stage ('Remove old blue deployment from AWS Loadbalancer') {
            steps {
               script {
                withAWS(credentials: 'aws-credentials', region: 'us-east-1'){
                   sh 'kubectl delete deploy/blue-deployment'
               }
               }
            }
        }

        stage ('Add latest blue deployment to AWS Loadbalancer') {
            steps {
               script {
                   withAWS(credentials: 'aws-credentials', region: 'us-east-1'){
                   sh 'kubectl apply -f deploy/blue.yml'
                   }
               }
            }
        }

        stage ('Remove old green deployment from AWS Loadbalancer') {
            steps {
               script {
                   withAWS(credentials: 'aws-credentials', region: 'us-east-1'){
                   sh 'kubectl delete deploy/green-deployment'
                   }
               }
            }
        }
    }
}
