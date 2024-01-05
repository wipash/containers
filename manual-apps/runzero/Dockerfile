FROM ubuntu:latest
LABEL org.opencontainers.image.source="https://github.com/wipash/containers"

ENV RUMBLE_AGENT_LOG_DEBUG=false

RUN mkdir -p /opt/rumble

RUN  apt-get update \
    && apt-get install -y curl \
    && curl -o chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get install -y ./chrome.deb \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf ./chrome.deb

USER root

COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
