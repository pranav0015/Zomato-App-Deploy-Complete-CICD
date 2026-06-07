# Multistage docker file in order to reduce the docker image size

FROM node:alpine AS builder

WORKDIR /app

COPY package*.json /app/

RUN npm install

COPY . . 

RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

