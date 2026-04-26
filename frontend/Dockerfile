FROM node:22-alpine AS build-env
COPY package.json package-lock.json ./
RUN npm install

RUN mkdir -p /usr/src/app && cp -R ./node_modules ./usr/src/app

WORKDIR /usr/src/app

COPY . ./

RUN npm run build --mode=production

FROM nginx:stable-alpine AS production

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build-env /usr/src/app/dist /usr/share/nginx/html/

COPY --from=build-env /usr/src/app/dist/* /tmpl/dist/web-app/

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY env.sh /docker-entrypoint.d/env.sh

RUN apk add --no-cache dos2unix && \
    dos2unix /docker-entrypoint.d/env.sh && \
    chmod +x /docker-entrypoint.d/env.sh && \
    apk del dos2unix

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]