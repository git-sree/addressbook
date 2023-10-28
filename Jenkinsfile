pipeline {
    agent any

    parameters {
        string(name: 'env', defaultValue: 'test', description: 'env to compile')
    }

    stages {
        stage('Compile') {
            steps {
                echo 'COMEPILE-Hello World'
                echo "compie env is: ${params.evn}"
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
