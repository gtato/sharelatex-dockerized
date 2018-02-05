FROM gtato/sharelatex-base:latest

RUN git clone https://github.com/sharelatex/tags-sharelatex.git /app ;\
    sed -i 's/localhost/0.0.0.0/g' /app/config/settings.defaults.coffee

WORKDIR /app

RUN npm install ;\
    grunt install

ADD app.sh /app/

EXPOSE 3012
CMD ["bash", "app.sh"]



