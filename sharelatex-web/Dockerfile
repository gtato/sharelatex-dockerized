FROM gtato/sharelatex-base:latest

RUN apt-get update && apt-get install -y nginx ;\
    git clone https://github.com/sharelatex/web-sharelatex.git /app

WORKDIR /app

ADD ChatController.coffee /app/app/coffee/Features/Chat/
RUN sed -i 's/headers: req.headers, //g' app/coffee/Features/Spelling/SpellingController.coffee ;\
    npm config set strict-ssl false; \
    npm install; \
	npm install bcrypt; \
	cd modules; \
	# git clone https://bitbucket.org/sharelatex/launchpad-webmodule.git launchpad; \
	grunt compile;

ADD settings.coffee /etc/sharelatex/
ADD users.coffee /app/

RUN grunt compile:minify ;\
    cat users.coffee >> Gruntfile.coffee ;\
    rm /etc/nginx/sites-enabled/default ;\
    mkdir -p /var/log/sharelatex/

ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/sharelatex.conf /etc/nginx/sites-enabled/sharelatex.conf
ADD app.sh /app/

EXPOSE 80
EXPOSE 3000

CMD ["bash", "app.sh"]

