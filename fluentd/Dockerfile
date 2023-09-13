# fluentd/Dockerfile

FROM fluent/fluentd:v1.16.2-debian-arm64-1.0
USER root

RUN ["gem", "install", "elasticsearch", "--no-document", "--version", "8.1.2"]
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-document", "--version", "5.2.2"]
RUN ["fluent-gem", "install", "fluent-plugin-multi-format-parser"]

USER fluent