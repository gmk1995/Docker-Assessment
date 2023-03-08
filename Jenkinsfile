pipeline {
    agent any
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
        timestamps()
    }
    environment {     
        DOCKERHUB_CREDENTIALS= credentials('Docker-Hub-Credentials')     
    } 
    stages{
        stage('GitCheckout') {
            steps{
                 git branch: 'main', credentialsId: 'GitHub_Credentials', url: 'https://github.com/gmk1995/Docker-Assessment.git'
            }
        }
        stage('DockerImageBuild') {
            steps{
                sh "sudo docker build -t gmk1995/nginx-welcomepage:v1 ."
            }
        }
        stage('DockerPush') {
            steps{
                sh "echo ${DOCKERHUB_CREDENTIALS} | sudo docker login -u gmk1995 --password-stdin"
                sh "sudo docker push gmk1995/nginx-welcomepage:v1"
            }
        }
        stage('DockerContainerCreating') {
            steps{
                sh "sudo docker run -d --name nginx-welcomepage-container -p 80:80 -e NGINX_PORT=80 -v /tmp/sample.txt:/opt/sample.txt  gmk1995/nginx-welcomepage:v1"
            }
        }
        stage('ContainerPortChecking&CronJobScheduling') {
            options{
                cron('*/5 * * * *')
            }
            steps{
                sh "sudo chmod 777 container_port_checking.sh"
                sh "sudo ./container_port_checking.sh"
            }
        }
    }
}