pipeline {
    agent any

    parameters {
        string(name: 'env', defaultValue: 'staging', description: 'enter environment value')
    }
    stages {
        stage('Compile') {
            steps {
                echo 'COMEPILE-Hello World'
                echo "Environment: ${params.env}"
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
