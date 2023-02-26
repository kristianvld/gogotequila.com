FROM node
RUN adduser app
WORKDIR /app
ADD ./package.json ./package-lock.json /app/
RUN npm install
ADD ./public /app/public
ADD ./src /app/src
ADD ./rollup.config.js /app/
RUN npm run build
EXPOSE 5000
USER app
CMD [ "npm",  "run", "start"]
