pipeline {
    agent any

    tools {
        jdk 'jdk21'            // ตั้งชื่อตรงกับที่ config ไว้ใน Jenkins
        maven 'maven3'         // ตั้งชื่อตรงกับที่ config ไว้ใน Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/khamteerapat/poc-jenkins-springboot'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Run') {
            steps {
                sh 'nohup java -jar target/*.jar &'
            }
        }
    }
}