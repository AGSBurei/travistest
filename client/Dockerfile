FROM node:16.13

WORKDIR /usr/src/app/front/

COPY package*json ./

RUN npm install

EXPOSE 8080

CMD ["npm","run" ,"serve"]