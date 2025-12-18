FROM alpine:latest
RUN apk add --no-cache bash
COPY java17 /opt/java17
ENV JAVA_HOME=/opt/java17
ENV PATH=$PATH:$JAVA_HOME/bin
COPY target/app.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
