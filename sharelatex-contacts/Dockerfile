FROM gtato/sharelatex-base:latest

RUN git clone https://github.com/sharelatex/contacts-sharelatex.git /app 
	
WORKDIR /app

RUN npm install ;\
    grunt install ;\
    sed -i 's/localhost/0.0.0.0/g' /app/config/settings.defaults.coffee 

EXPOSE 3036

ADD app.sh /app/
CMD ["bash", "app.sh"]



