# Jenkins_CICD

## What do we need ?

### Jenkins

An `open-source automation server` written in Java. It is primarily used to implement Continuous Integration (CI) and Continuous Delivery (CD) pipelines. It automates the parts of software development related to building, testing, and deploying, facilitating consistent collaboration between developers and operations teams (DevOps).

**Key Features:**

- `Pipeline as Code`: You can define your build, test, and deploy pipelines in a text file (called a Jenkinsfile) committed to your source code repository.

- `Plugin Ecosystem`: It has a massive library of over 1,800 plugins, allowing it to integrate with almost every tool in the DevOps toolchain (e.g., Git, Docker, Kubernetes, Slack).

- `Distributed Builds`: Jenkins uses a "Controller-Agent" architecture (formerly Master-Slave), allowing it to distribute build workloads across multiple machines to save time.

- `Extensibility`: It is highly customizable, allowing developers to create custom workflows for everything from simple code compilation to complex cloud infrastructure deployment.

**Primary Use Case:** A developer pushes code to GitHub. Jenkins detects the change, automatically downloads the code, runs automated tests, builds a Docker container, and deploys it to a staging server.

### PostgreSQL

A powerful, `open-source Object-Relational Database Management System (ORDBMS)`. It is known for its **reliability**, **robust feature set**, and **strict adherence to SQL standards**. Unlike simple relational databases, "Object-Relational" means it supports complex data types and objects (like inheritance and function overloading) typically found in programming languages.

**Key Features:**

- `ACID Compliance:` It guarantees Atomicity, Consistency, Isolation, and Durability, making it highly reliable for critical financial or transactional data.

- `Advanced Data Types:` Beyond standard numbers and text, it natively supports JSON (allowing it to function like a NoSQL database), Arrays, and XML.

- `Extensibility:` Users can define their own data types, operators, and index types. It also has a famous extension called PostGIS which turns it into the industry standard for geospatial (map) data.

- `Concurrency:` It uses Multi-Version Concurrency Control (MVCC), which allows multiple readers and writers to access the database simultaneously without locking the entire table, ensuring high performance.

**Primary Use Case**: It serves as the primary "source of truth" backend database for web applications, mobile apps, and analytics platforms (e.g., storing user profiles for Instagram or banking transactions).

## Installation

You can install theses tools within **two ways** :

### First way

- To install postgresql :

    ```bash
    sudo apt install postgresql postgresql-contrib -y
    ```

    - To make your first connection, type :
    ```bash
    sudo -i -u postgres
    ```



- To install Jenkins :

    ```bash
    sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt update
    sudo apt install jenkins
    ```

    - After that you can type on your browser : `localhost:8080`. Then you have an interface to make connection, the initial password is given by :
    ```bash
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
### Second way

In `./Jenkins_CICD/Setup` folder you have two file ready to be executed. The command below will launch two containers : **Jenkins & Postgres**

```bash
docker-compose up -d --build
```

After that you must try to connect on Jenkins user interface so you need a initial password :
```bash
docker exec jenkins_try cat /var/jenkins_home/secrets/initialAdminPassword
```