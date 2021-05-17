#build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN ["npm","run","build"]

#run phase, using a new from command it's automatically interpreted as a new step
FROM nginx
EXPOSE 80
#from nginx docs copying result from the first phase
COPY --from=builder /app/build /usr/share/nginx/html 
