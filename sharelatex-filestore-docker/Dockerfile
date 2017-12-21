FROM sharelatex-node:latest

RUN git clone https://github.com/sharelatex/filestore-sharelatex.git /app
WORKDIR /app

RUN npm install
RUN grunt install

RUN sed -i 's/localhost/0.0.0.0/g' config/settings.defaults.coffee
RUN sed -i "s/__dirname + \"\/../\"\/app\/data/g" config/settings.defaults.coffee

#RUN mkdir -p /app/data /app/data/user_files /app/data/public_files /app/data/template_files /app/data/uploads

ADD app.sh /app/

EXPOSE 3009

VOLUME ["/app/data/"]

CMD ["bash", "app.sh"]
