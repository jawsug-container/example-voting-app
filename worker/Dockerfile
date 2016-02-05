FROM pottava/maven:3.3-java7

WORKDIR /app

ADD pom.xml /app/pom.xml
RUN mvn dependency:resolve && \
    mvn verify

ADD . /app
RUN mvn package

CMD ["java", "-jar", "target/worker-jar-with-dependencies.jar"]
