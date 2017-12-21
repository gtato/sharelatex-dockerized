FROM sharelatex-node:latest

RUN git clone https://github.com/sharelatex/contacts-sharelatex.git /app
WORKDIR /app
RUN sed -i 's/localhost/0.0.0.0/g' config/settings.defaults.coffee

RUN npm install
RUN grunt install

EXPOSE 3036

ADD app.sh /app/
CMD ["bash", "app.sh"]



