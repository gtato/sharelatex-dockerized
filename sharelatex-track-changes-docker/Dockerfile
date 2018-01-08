FROM sharelatex-node:latest

RUN git clone https://github.com/sharelatex/track-changes-sharelatex.git /app
WORKDIR /app

RUN npm install
RUN grunt install

ADD settings.defaults.coffee /app/config

EXPOSE 3015

ADD app.sh /app/
CMD ["bash", "app.sh"]

