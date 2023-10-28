pipeline {
    agent any

    parameters {
        string(name: 'env', defaultValue: 'test', description: 'env to compile')
        string(name: 'branch', defaultValue: 'main', description: 'branch is main')
        booleanParam(name: 'execute', defaultValue: true, description: 'decide to run on it')
        choice(name: 'build_env', choices: ['staging','dev','prod'], description: 'select env for staging')
    }

    stages {
        stage('Compile') {
            steps {
                echo 'COMEPILE-Hello World'
                echo "compie env is: ${params.env}"
            }
        }
         stage('Test') {
            when{
                expression{
                    params.execute == true
                }
            }
            steps {
                echo 'TEST-Hello World'
            }
        }
        stage('Package') {
            steps {
                echo 'PACKAGE-Hello World'
            }
        }
        stage('Deploy') {
            input{
                message "select the version to deploy."
                ok "version selected."
                parameters{
                    choice(name: 'new version', choices: ['1.0','2.0','3.0'])
                }
            }
            steps {
                echo 'deploy-Hello World'
            }
        }
        
    }
}
