pipeline {
    agent any

    parameters {
        string(name: 'env', defaultValue: 'staging', description: 'Name of Environment')
        booleanParam(name: 'execute', defaultValue: true, description: 'decide job to run')
        choice(name: 'version', choices: ['1.1', '1.2', '1.3'])
    }

    stages {
        stage('compile') {
            steps {
                script {
                    echo "compile- hello world"
                    echo "${params.env}"
                    echo "${params.version}"
                    echo "${params.execute}"
                }
            }
        }

        stage('test') {
            steps {
                script {
                    echo "test- hello world"
                }
            }
        }

        stage('package') {
            steps {
                script {
                    echo "package- hello world"
                }
            }
        }
    }
}
