FROM node:15.14.0-stretch

COPY package.json yarn.lock /

RUN yarn

COPY . /

ENV REST_URL=https://conduit.productionready.io/api
ENV PORT=443

CMD \
  grep -lR conduit.productionready.io/api app/ | xargs sed -i 's_https://conduit.productionready.io/api_'$REST_URL'_' && \
  echo "export const config = {rest_url: '$REST_URL'};" > /app/config.js && \
  yarn build && \
  cp index.js /dist && node /dist/index.js
