pipeline {
    agent none

    tools {
        maven 'mymaven'
        jdk 'myjava'
    }
    environment {
        ssh_agent_dev_server='ec2-user@172.31.47.165'
    }
    parameters {
        string(name: 'env', defaultValue: 'staging', description: 'Name of Environment')
        booleanParam(name: 'execute', defaultValue: true, description: 'decide job to run')
        choice(name: 'version', choices: ['1.1', '1.2', '1.3'])
    }

    stages {
        stage('compile') {
            agent {label 'develop-server'}
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
            agent {label 'deploy-server'}
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
                        echo "package- hello world"
                        sh "scp -o StrictHostKeyChecking=no server-config.sh ${ssh_agent_dev_server}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${ssh_agent_dev_server} 'bash ~/server-config.sh'"
                        //sh "mvn package"
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
                    echo "deploy- hello world"
                }
            }
        }
    }
}
