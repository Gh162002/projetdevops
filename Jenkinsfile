pipeline {
    agent any
    tools {
        maven 'M2_HOME'
        jdk 'JAVA_HOME'
    }

    environment {
        DOCKER_USERNAME = 'Gh162002'
        IMAGE_NAME      = 'projetdevops'
    }

    stages {
        stage('Checkout GITT') {
            steps {
                echo 'Pulling code...'
                git branch: 'ghada', url: 'https://github.com/Gh162002/projetdevops.git'
            }
        }

        stage('Compiling the artifact') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('mvn SonarQube') {
            steps {
                withCredentials([string(credentialsId: 'token-sonar', variable: 'SONAR_TOKEN')]) {
                    sh "mvn sonar:sonar -Dsonar.login=${SONAR_TOKEN}"
                }
            }
        }

        stage('Package JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-token',
                                                  usernameVariable: 'DOCKER_USER',
                                                  passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
                        docker tag ${IMAGE_NAME} ${DOCKER_USER}/${IMAGE_NAME}:latest
                        docker push ${DOCKER_USER}/${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }
}
