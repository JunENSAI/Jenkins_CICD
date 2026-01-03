FROM jenkins/jenkins:lts-jdk17

USER root

RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv libpq-dev && \
    apt-get clean
    
USER jenkins