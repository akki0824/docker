#node block
FROM node:alpine3.16 as nodework
#
WORKDIR /myapp
#copy json to current directory /myapp
COPY package.json .
#dependancies used to serve files
RUN npm install
#copying files from local to current directory /myapp
COPY . .
#build
RUN npm run build

#nginx block
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
COPY --from=nodework /myapp/build .
COPY --from=nodework /myapp/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD [ "nginx", "-g", "deamon off;" ]



