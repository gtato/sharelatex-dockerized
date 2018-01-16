FROM sharelatex-node:latest

RUN apt-get update && apt-get install -y nginx

RUN git clone https://github.com/sharelatex/web-sharelatex.git /app
WORKDIR /app
RUN sed -i 's/headers: req.headers, //g' app/coffee/Features/Spelling/SpellingController.coffee
RUN npm install; \
	npm install bcrypt; \
	cd modules; \
	git clone https://bitbucket.org/sharelatex/launchpad-webmodule.git launchpad; \
	grunt compile;
	
RUN grunt compile:minify

ADD settings.coffee /etc/sharelatex/

ADD users.coffee /app/
RUN cat users.coffee >> Gruntfile.coffee

RUN rm /etc/nginx/sites-enabled/default
ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/sharelatex.conf /etc/nginx/sites-enabled/sharelatex.conf


RUN mkdir -p /var/log/sharelatex/

ADD app.sh /app/

EXPOSE 80
EXPOSE 3000

CMD ["bash", "app.sh"]

