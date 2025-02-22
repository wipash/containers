FROM node:20 AS builder

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

USER node

WORKDIR /tmp/node_app

ENV NODE_ENV=development
ENV VITE_APP_PORTAL_URL=""
ENV VITE_APP_DISABLE_TRACKING=true
ENV VITE_APP_WS_SERVER_URL=http://localhost:3002

RUN git clone "https://github.com/excalidraw/excalidraw.git" . && \
  if [ -n "$VERSION" ]; then \
    git checkout v$VERSION; \
  fi  && \
  sed -i 's|"excalidraw.production.min": "./entry.js",|"excalidraw.production.min": "../../excalidraw-app/index.ts",|g' ./src/packages/excalidraw/webpack.prod.config.js && \
  sed -i 's|simpleanalyticscdn.com|localhost|g'  ./index.html && \
  yarn --ignore-optional --network-timeout 600000

RUN yarn build:app:docker

FROM ghcr.io/nginxinc/nginx-unprivileged:1.27-alpine

ENV COLLAB_ADDR=http://localhost:3002

WORKDIR /usr/share/nginx/html

USER root

COPY --from=builder /tmp/node_app/build /usr/share/nginx/html

RUN chown -R nginx:nginx /usr/share/nginx/html

USER nginx

ENTRYPOINT [ "/bin/ash" ]

CMD [ "-c", "sed -i s,http://localhost:3002,$COLLAB_ADDR,g /usr/share/nginx/html/assets/*.js && /docker-entrypoint.sh nginx -g 'daemon off;'" ]

LABEL org.opencontainers.image.source="https://github.com/excalidraw/excalidraw"
