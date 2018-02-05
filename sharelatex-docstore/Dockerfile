FROM gtato/sharelatex-base:latest

RUN git clone https://github.com/sharelatex/docstore-sharelatex.git /app
WORKDIR /app

RUN npm install ;\
    grunt install ;\
    sed -i 's/localhost/0.0.0.0/g' config/settings.defaults.coffee

EXPOSE 3016

ADD app.sh /app/
CMD ["bash", "app.sh"]



