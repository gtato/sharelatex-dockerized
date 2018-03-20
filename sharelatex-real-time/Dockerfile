FROM gtato/sharelatex-base:latest

RUN git clone https://github.com/sharelatex/real-time-sharelatex.git /app
WORKDIR /app

ADD settings.defaults.coffee /app/config

RUN sed -i 's/v: update.v, doc: update.doc/v: update.v, doc: update.doc, client_ts: update.client_ts, client_rid: update.client_rid/g' app/coffee/DocumentUpdaterController.coffee ;\
    npm install ; \ 
    grunt install

EXPOSE 3026

CMD ["node", "app.js"]

