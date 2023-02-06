# Stage 1 (to create a "build" image, ~360MB)
FROM eclipse-temurin:17-jdk-alpine AS builder
# smoke test to verify if java is available
RUN java -version

COPY . /usr/src/myapp/
WORKDIR /usr/src/myapp/
RUN set -Eeux \
    && apk --no-cache add maven \
    # smoke test to verify if maven is available
    && mvn --version
RUN mvn package
EXPOSE 8123
ENTRYPOINT ["java", "-jar", "./app.jar"]
