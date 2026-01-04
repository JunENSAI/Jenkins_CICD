pipeline {
    agent any

    // Input ask when you build with parameters
    parameters {
        string(name: 'DB_USER', defaultValue: 'jenkins_user', description: 'Database User')
        string(name: 'DB_NAME', defaultValue: 'your_db_name', description: 'Database Name')
        password(name: 'DB_PASS', defaultValue: 'your_password', description: 'Database Password')
    }

    environment {
        // map the input parameters to Environment Variables safely
        DB_USER = "${params.DB_USER}"
        DB_NAME = "${params.DB_NAME}"
        DB_PASS = "${params.DB_PASS}"
    }

    stages {
        stage('Setup Environment') {
            steps {
                echo '--- Creating Virtual Environment ---'
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Database Check') {
            steps {
                echo '--- Running Python Scripts ---'
                // We use the same virtual environment
                sh '''
                    . venv/bin/activate
                    python database_check.py
                '''
            }
        }
    }
}