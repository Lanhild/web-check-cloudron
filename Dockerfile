ARG VERSION=latest

FROM cloudron/base:4.2.0@sha256:46da2fffb36353ef714f97ae8e962bd2c212ca091108d768ba473078319a47f4 AS base

FROM lissy93/web-check:${VERSION} as app

FROM base AS runner

ENV NODE_ENV production
WORKDIR /app/code

ARG NODE_VERSION=21
RUN mkdir -p /usr/local/node-${NODE_VERSION} && curl -L https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | tar zxf - --strip-components 1 -C /usr/local/node-${NODE_VERSION}
ENV PATH /usr/local/node-${NODE_VERSION}/bin:$PATH

COPY --from=app ./app ./web-check
COPY --from=app ./usr/bin/chromium ./chromium

ENV CHROME_PATH='/app/code/chromium'

COPY env.sh.template start.sh /app/pkg/

CMD [ "/app/pkg/start.sh" ]

