### STAGE 1: Build ###
FROM node:12.7-alpine AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
#FROM nginx:1.17.1-alpine
FROM nginxinc/nginx-unprivileged 

#COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /usr/src/app/dist/aston-villa-app /usr/share/nginx/html

#RUN chgrp -R root /var/cache/nginx /var/run /var/log/nginx && \
#    chmod -R 770 /var/cache/nginx /var/run /var/log/nginx
