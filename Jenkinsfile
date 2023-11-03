pipeline {
    agent none

    tools {
        maven 'mymaven'
        jdk 'myjava'
    }
    environment {
        // Agent server using ssh agent to run package
        ssh_agent_dev_server='ec2-user@172.31.47.165'
        // dev, deploy agents using sshagent using docker 
        docker_develop_server='ec2-user@172.31.32.165'
        docker_deploy_server='ec2-user@172.31.40.11'
        IMAGE_NAME='dockersree6/java-app-docker'
    }
    parameters {
        string(name: 'env', defaultValue: 'staging', description: 'Name of Environment')
        booleanParam(name: 'execute', defaultValue: true, description: 'decide job to run')
        choice(name: 'version', choices: ['1.1', '1.2', '1.3'])
    }

    stages {
        stage('compile') {
            // agent {label 'develop-server'}
            agent any
            steps {
                script {
                    echo "compile- hello world"
                    echo "${params.env}"
                    echo "${params.version}"
                    echo "${params.execute}"
                    sh "mvn compile"
                }
            }
        }

        stage('test') {
            // agent {label 'deploy-server'}
            agent any
            when {
                expression{
                    params.execute == true
                }
            }
            steps {
                script {
                    echo "test- hello world"
                    sh "mvn test"
                }
                
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('package') {
            agent any
            steps {
                script {
                    sshagent(['aws-key']) {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerpwd', usernameVariable: 'dockeruser')]) {
                            echo "package- hello world"
                            sh "scp -o StrictHostKeyChecking=no server-config.sh ${docker_develop_server}:/home/ec2-user"
                            sh "ssh -o StrictHostKeyChecking=no ${docker_develop_server} 'bash ~/server-config.sh ${IMAGE_NAME} ${BUILD_NUMBER}'"
                            sh "ssh ${docker_develop_server} sudo docker login -u ${dockeruser} -p ${dockerpwd}"
                            ss "ssh ${docker_develop_server} sudo docker image push ${IMAGE_NAME}:${BUILD_NUMBER}"

                            //sh "mvn package"
                        }
                    }
                    
                }
            }
        }

        stage('deploy') {
            agent any
            input {
                message "Select version to deploy"
                ok "version selected"
                parameters {
                   choice(name: 'new_version', choices: ['3.6', '4.6']) 
                }
            }
            steps {
                script {
                    sshagent(['aws-key']) {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerpwd', usernameVariable: 'dockeruser')]) {
                            echo "deploy- hello world"
                            sh "ssh -o StrictHostKeyChecking=no ${docker_deploy_server} sudo yum install docker -y"
                            sh "ssh ${docker_deploy_server} sudo systemctl start docker"
                            sh "ssh ${docker_deploy_server} sudo docker login -u ${dockeruser} -p ${dockerpwd}"
                            sh "${docker_deploy_server} sudo docker container run -d --name web-ab -p 6666:8080 ${IMAGE_NAME}:${BUILD_NUMBER}"
                        }
                    }
                }
            }
        }
    }
}
