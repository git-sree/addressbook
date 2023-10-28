pipeline {
    agent none

    tools {
        maven 'mymaven'
        jdk 'myjava'
    }

    parameters {
        string(name: 'env', defaultValue: 'test', description: 'env to compile')
        string(name: 'branch', defaultValue: 'main', description: 'branch is main')
        booleanParam(name: 'execute', defaultValue: true, description: 'decide to run on it')
        choice(name: 'build_env', choices: ['staging','dev','prod'], description: 'select env for staging')
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                script {
                    echo 'COMEPILE-Hello World'
                    echo "compie env is: ${params.env}"
                    sh "mvn compile"
                }
            }
        }
         stage('Test') {
            agent any
            when{
                expression{
                    params.execute == true
                }
            }
            steps {
                script{
                    echo 'TEST-Hello World'
                    sh "mvn test"
                }
            }
            post {
                always {
                    junit 'target/surefile-reports/*.xml'
                }
            }
        }
        stage('Package') {
            agent {label 'apple-slave2'}
            steps {
                script {
                    echo 'PACKAGE-Hello World'
                    sh "mvn package"
                }
            }
        }
        stage('Deploy') {
            agent any
            input{
                message "select the version to deploy."
                ok "version selected."
                parameters{
                    choice(name: 'new version', choices: ['1.0','2.0','3.0'])
                }
            }
            steps {
                script {
                    echo 'Deploy-Hello World'
                }
            }
        }
        
    }
}
