pipeline {
    agent any

    /*
    // use parameters when you are new on jenkins, it will ask you to complete all of the parameter in UI
    parameters {
        string(name: 'DB_USER', defaultValue: 'jenkins_user', description: 'Database User')
        string(name: 'DB_NAME', defaultValue: 'your_db_name', description: 'Database Name')
        password(name: 'DB_PASS', defaultValue: 'your_password', description: 'Database Password')
    }
    */

    environment {
        /*
        map the input parameters to Environment Variables safely
        DB_USER = "${params.DB_USER}"
        DB_NAME = "${params.DB_NAME}"
        DB_PASS =  params.DB_PASS //"${params.DB_PASS}"
        */

        // if you don't want to add always the parameter create a credials to store all of your parameters definitely
        DB_CREDS = credentials('my-local-postgres')
    }

    stages {
        stage('Setup & Test') {
            steps {
                echo '--- Testing Connection with Stored Credentials ---'
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                    python database_check.py
                '''
            }
        }
    }
}