pipeline {
    agent {
        docker {
            // Jenkins will download this image, start it, run your steps, and delete it.
            // We use an image that already has Python 3.9 installed.
            image 'python:3.9-slim' 
            
            // Critical: We map the local network so the container can see your Postgres on localhost
            args '--network="host"'
        }
    } // default parameter is : any if you don't want agent

    /*
    // use parameters when you are new on jenkins, it will ask you to complete all of the parameter in UI
    parameters {
        string(name: 'DB_USER', defaultValue: 'jenkins_user', description: 'Database User')
        string(name: 'DB_NAME', defaultValue: 'your_db_name', description: 'Database Name')
        password(name: 'DB_PASS', defaultValue: 'your_password', description: 'Database Password')
    }
    */

    /*
    // Triggers define WHEN the job runs automatically
    triggers {
        // Run every night at 3:00 AM
        // Cron Syntax: Minute Hour Day Month DayOfWeek
        cron('H 3 * * *') 
    }*/

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

        DISCORD_URL = credentials('discord-webhook-url')

        // Define a filename based on the current date
        // e.g., backup-2023-10-27.sql
        //BACKUP_FILE = "backup-${new Date().format('yyyy-MM-dd')}.sql"
    }

    stages {
        stage('Setup python env') {
            steps {
                sh '''
                    python3 -m venv jenkins_env
                    . jenkins_env/bin/activate
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Quality & Checks') {
            failFast true // If one fails, stop the other immediately to save time
            parallel {
                
                // Branch A: The Unit Tests
                stage('Unit Tests') {
                    steps {
                        echo '--- Running Pytest ---'
                        sh '''
                            export DB_USER=$DB_CREDS_USR
                            export DB_PASS=$DB_CREDS_PSW
                            export DB_NAME=$DB_NAME
                            . jenkins_env/bin/activate
                            python3 -m pytest test_connection.py
                        '''
                    }
                }

                // Branch B: Code Quality (Linting)
                stage('Linting') {
                    steps {
                        echo '--- Checking Code Style ---'
                        // fail-under=90 means if code score is below 9/10, FAIL the build.
                        // We exclude venv so it doesn't check library files.
                        sh 'python3 -m flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics'
                        sh 'python3 -m flake8 . --count --max-complexity=10 --max-line-length=127 --statistics'
                    }
                }
            }
        }
        
        // Only deploy if BOTH parallel stages passed
        stage('Deploy') {
             steps {
                 echo '--- Deployment Placeholder ---'
             }
        }
        /*
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
        */

        /*
        stage('Perform Backup') {
            steps {
                echo "--- Backing up ${DB_NAME} to ${BACKUP_FILE} ---"
                
                // We use PGPASSWORD env var so pg_dump doesn't ask for a password interactively
                sh '''
                    export PGPASSWORD=$DB_CREDS_PSW
                    
                    # Run pg_dump
                    # -h localhost : Host
                    # -U ...       : Username
                    # -F p         : Format plain text (so you can read it)
                    # -f ...       : Output filename
                    pg_dump -h localhost -U $DB_CREDS_USR -F p -f $BACKUP_FILE $DB_NAME
                '''
            }
        }
        */
        /*
        // Just imagine if you are DROP by accident your table 
        stage('Restore Database') {
            steps {
                echo "--- STARTING RESTORE PROCEDURE ---"
                
                script {
                    // Check if file was actually uploaded
                    if (!fileExists('restore_upload.sql')) {
                        error "No backup file uploaded!"
                    }
                }

                // Run psql to inject the SQL file back into the database
                sh '''
                    export PGPASSWORD=$DB_CREDS_PSW
                    
                    echo "Restoring from uploaded file..."
                    psql -h localhost -U $DB_CREDS_USR -d $DB_NAME -f restore_upload.sql
                '''
            }
        }
        */
    }
    /*
    // Post-actions: Run this whether the build succeeds or fails
    post {
        always {
            junit 'results.xml' 
            
            // Archive Artifacts: This saves the file inside Jenkins permanently
            // You can download it from the Jenkins UI later
            archiveArtifacts artifacts: '*.sql', fingerprint: true
            
        }
    }
    */
    // Send notification to discord server teams
    post {
        success {
            discordSend description: "Build Succeeded!", 
                        footer: "Jenkins Agent: Docker", 
                        link: env.BUILD_URL, 
                        result: currentBuild.currentResult, 
                        title: "${env.JOB_NAME} - Build #${env.BUILD_NUMBER}", 
                        webhookURL: env.DISCORD_URL
        }
        failure {
            discordSend description: "Build FAILED ", 
                        footer: "Check the logs immediately.", 
                        link: env.BUILD_URL, 
                        result: currentBuild.currentResult, 
                        title: "${env.JOB_NAME} - Build #${env.BUILD_NUMBER}", 
                        webhookURL: 'PASTE_YOUR_DISCORD_URL_HERE'
        }
    }
    
}