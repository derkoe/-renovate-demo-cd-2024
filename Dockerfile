FROM maven:3-eclipse-temurin-11@sha256:5a781a7e008965e5631baa8240150d81e0de730377112f58b8c30a0a28c3e570 as builder

WORKDIR /build
COPY . .
RUN mvn clean verify

FROM eclipse-temurin:11.0.23_9-jre@sha256:b074dd1f14c752c818fd2bf118db451b19b207700e52383bdf7a31412c876a90

# renovate: datasource=github-releases depName=apangin/jattach
ENV JATTACH_VERSION=1.5

RUN curl -Lo /usr/local/bin/jattach https://github.com/apangin/jattach/releases/download/v${JATTACH_VERSION}/jattach \
 && chmod +x /usr/local/bin/jattach

COPY --from=builder /build/target/demo.jar /demo.jar

ENTRYPOINT ["java", "-jar", "/demo.jar"]
