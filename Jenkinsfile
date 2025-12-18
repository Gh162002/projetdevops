pipeline {
    agent any
    tools {
        maven 'M2_HOME'
        jdk 'JAVA_HOME'
    }

    environment {
        IMAGE_NAME = 'projetdevops'
        DOCKER_USER = 'Gh162002'
    }

    stages {
        stage('Checkout GIT') {
            steps {
                git branch: 'ghada',
                    url: 'https://github.com/Gh162002/projetdevops.git'
            }
        }

        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }

        stage('Compiling') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('SonarQube') {
            steps {
                withCredentials([string(credentialsId: 'token-sonar',
                                        variable: 'SONAR_TOKEN')]) {
                    sh "mvn sonar:sonar -Dsonar.login=${SONAR_TOKEN}"
                }
            }
        }

        stage('Package JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
                sh 'cp target/*-jar-with-dependencies.jar target/app.jar'
            }
        }

        stage('Build image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Push Docker') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'docker-token',
                                          usernameVariable: 'DOCKER_USER',
                                          passwordVariable: 'DOCKER_PASS')]) {
            sh '''
                docker login -u $DOCKER_USER --password-stdin <<< "$DOCKER_PASS"
                docker tag projetdevops $DOCKER_USER/projetdevops:latest
                docker push $DOCKER_USER/projetdevops:latest
            '''
        }
    }
}
    }
}
