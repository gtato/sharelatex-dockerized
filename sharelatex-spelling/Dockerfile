FROM gtato/sharelatex-base:latest

RUN apt-get update && apt-get install -y aspell aspell-en ;\ 
     git clone https://github.com/sharelatex/spelling-sharelatex.git /app
WORKDIR /app
RUN npm install ;\
    grunt install

ADD settings.defaults.coffee /app/config/

EXPOSE 3005


ADD app.sh /app/
CMD ["bash", "app.sh"]



