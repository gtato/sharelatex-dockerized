FROM sharelatex-web:latest


RUN rm -r /app/* ;\
	mkdir -p /var/log/sharelatex/
ADD app.js /app/
ADD nginx/sharelatex.conf /etc/nginx/sites-enabled/sharelatex.conf
ADD app.sh /app/

EXPOSE 80
EXPOSE 3000

CMD ["bash", "app.sh"]

