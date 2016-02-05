FROM pottava/nodejs

WORKDIR /app

ADD package.json /app/package.json
RUN npm install

ADD . /app

ENV PORT 80
EXPOSE 80

CMD ["node", "server.js"]
