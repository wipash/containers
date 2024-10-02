FROM golang:1.23.2

ARG VERSION

USER root
WORKDIR /app

ENV GOOS=linux
ENV GOARCH=amd64
ENV PORT=8080

RUN curl -fsSL "https://github.com/plandex-ai/plandex/archive/refs/tags/server/v${VERSION}.tar.gz" \
    | tar xzf - -C /tmp --strip-components=1 && \
    cd /tmp/app/shared && \
    go mod download && \
    cd /tmp/app/server && \
    go mod download && \
    mkdir -p /app && \
    go build -o /app/plandex-server . && \
    cp -r /tmp/app/server/migrations /app && \
    cd /app && \
    chown -R root:root /app && \
    chmod -R 755 /app && \
    rm -rf /tmp/*

CMD ["./plandex-server"]
