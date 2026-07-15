FROM maven:3.9.8-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline
COPY src ./src
RUN mvn -q -DskipTests clean package \
    && jar xf target/skipper-cms-server-0.1.0.jar META-INF/MANIFEST.MF \
    && grep -q "Main-Class: org.springframework.boot.loader.launch.JarLauncher" META-INF/MANIFEST.MF \
    && grep -q "Start-Class: com.skipper.cms.SkipperCmsApplication" META-INF/MANIFEST.MF

FROM eclipse-temurin:17-jre
WORKDIR /app
ENV JAVA_OPTS=""
COPY --from=build /app/target/skipper-cms-server-0.1.0.jar /app/skipper-cms-server.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/skipper-cms-server.jar"]
