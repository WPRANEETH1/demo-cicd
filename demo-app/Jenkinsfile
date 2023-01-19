pipeline {
    environment {
		REGION = 'us-east-1'
		REPO_URL = '103750175519.dkr.ecr.us-east-1.amazonaws.com/demo-app'
		AWS_ECS_CLUSTER = 'ecs-fargate-test'
        AUTH_SVC = 'demo-app-test'
    }  
	agent any
    stages {
        stage("Pre Steps"){
            steps{
                sh "aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${REPO_URL}"
            }
        }
		stage('Clone Project') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'master', url: 'git@github.com:WPRANEETH1/demo-app.git'
			}
		}
        stage('Build') {
            steps {   
                script {
					echo "Building demo-app"
					sh "mvn package"				
                }
            }
        }   
        stage('Run Tests') {
            steps {             
                sh "mvn test" 
                junit '**/target/surefire-reports/*.xml'
            }
        }
        stage('Archive Artifact') {
            steps {
                archiveArtifacts(artifacts: '**/target/*.jar', allowEmptyArchive: true)
            }
        }      
        stage('Docker Build') {
            steps {   
                script {
					sh "docker build -t demo-app -f Dockerfile ."
					sh "docker tag demo-app:latest ${REPO_URL}:latest"					
                }
            }
        }					
        stage('Docker push') {
            steps {             
                sh "docker push ${REPO_URL}:latest"
            }
        }
        stage('Promotion?') {
          steps {
            script {
              input(
                message: 'Proceed with above Terraform Plan??',
                ok: 'Proceed'
              )
            }
          }
        }        
		stage('Deploy in ECS') {
			steps {
				script {
					sh("aws ecs update-service --cluster ${AWS_ECS_CLUSTER} --region ${REGION} --service ${AUTH_SVC} --force-new-deployment")
				}
			}
		}		
    }
}



