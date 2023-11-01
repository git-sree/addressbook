pipeline {
    agent none

    tools {
        maven 'mymaven'
        jdk 'myjava'
    }

    parameters {
        string(name: 'env', defaultValue: 'staging', description: 'Name of Environment')
        booleanParam(name: 'execute', defaultValue: true, description: 'decide job to run')
        choice(name: 'version', choices: ['1.1', '1.2', '1.3'])
    }

    stages {
        stage('compile') {
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

                post{
                    always {
                        echo "post block added"
                    }
                }
            }
        }

        stage('package') {
            agent {label 'develop-server'}
            steps {
                script {
                    echo "package- hello world"
                    sh "mvn package"
                }
            }
        }

        stage('deploy') {
            agent {
                label 'deploy-server'
            }
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
