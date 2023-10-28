pipeline {
    agent any

    parameters {
        string(name: 'env', defaultValue: 'test', description: 'env to compile')
        string(name: 'branch', defaultValue: 'main', description: 'branch is main')
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
            steps {
                echo 'TEST-Hello World'
            }
        }
        stage('Package') {
            steps {
                echo 'PACKAGE-Hello World'
            }
        }
    }
}
