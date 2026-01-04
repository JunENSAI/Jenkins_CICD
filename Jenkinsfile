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

        DB_NAME = "db_jenkins"
    }

    stages {
        stage('Setup') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Unit Tests') {
            steps {
                echo '--- Running Pytest ---'
                sh '''
                    export DB_USER=$DB_CREDS_USR
                    export DB_PASS=$DB_CREDS_PSW
                    export DB_NAME=$DB_NAME
                    
                    . venv/bin/activate
                    
                    # Run tests and save result to a file (junit.xml)
                    # This allows Jenkins to make a graph of your test results!
                    pytest --junitxml=results.xml test_connection.py
                '''
            }
        }

        stage('Deploy to DB') {
            steps {
                echo '--- Deploying Database Changes ---'
                sh '''
                    export DB_USER=$DB_CREDS_USR
                    export DB_PASS=$DB_CREDS_PSW
                    export DB_NAME=$DB_NAME
                    
                    . venv/bin/activate
                    python create_table.py
                '''
            }
        }
    }
    
    // Post-actions: Run this whether the build succeeds or fails
    post {
        always {
            junit 'results.xml' 
        }
    }
}