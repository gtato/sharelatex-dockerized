FROM sharelatex-base:latest

RUN git clone https://github.com/sharelatex/document-updater-sharelatex.git /app
WORKDIR /app

ADD settings.defaults.coffee /app/config

RUN npm install ;\
    grunt install

EXPOSE 3003

ADD app.sh /app/
CMD ["bash", "app.sh"]


