FROM sharelatex-web:latest


RUN rm -r /app/*
ADD app.js /app/
ADD nginx/sharelatex.conf /etc/nginx/sites-enabled/sharelatex.conf
RUN mkdir -p /var/log/sharelatex/
ADD app.sh /app/

EXPOSE 80
EXPOSE 3000

CMD ["bash", "app.sh"]

