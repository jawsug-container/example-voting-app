FROM pottava/maven:3.3-java7

ADD . /app
WORKDIR /app

RUN mvn dependency:resolve && \
    mvn verify && \
    mvn package

CMD ["java", "-jar", "target/worker-jar-with-dependencies.jar"]
