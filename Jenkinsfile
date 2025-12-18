stage('Package JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
                sh 'cp target/*-jar-with-dependencies.jar target/app.jar'
            }
        }
