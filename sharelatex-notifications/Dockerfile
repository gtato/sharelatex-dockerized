FROM gtato/sharelatex-base:latest

RUN git clone https://github.com/sharelatex/notifications-sharelatex.git /app
WORKDIR /app
RUN sed -i 's/localhost/0.0.0.0/g' config/settings.defaults.coffee ;\
    npm install ;\
    grunt install

EXPOSE 3042

ADD app.sh /app/
CMD ["bash", "app.sh"]


