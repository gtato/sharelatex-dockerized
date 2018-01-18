FROM sharelatex-base:latest

RUN git clone https://github.com/sharelatex/real-time-sharelatex.git /app
WORKDIR /app

ADD settings.defaults.coffee /app/config

RUN npm install ; \ 
    grunt install

EXPOSE 3026

CMD ["node", "app.js"]

