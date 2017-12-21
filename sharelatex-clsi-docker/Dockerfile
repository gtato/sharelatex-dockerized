FROM sharelatex-node:latest

RUN apt-get update && apt-get install -y python git-core build-essential zlib1g-dev latexmk 

RUN git clone https://github.com/sharelatex/clsi-sharelatex.git /app
WORKDIR /app
RUN sed -i 's/localhost/0.0.0.0/g' config/settings.defaults.coffee

RUN npm install v8-profiler
RUN npm install
RUN grunt install

RUN mkdir /app/compiles /app/cache

EXPOSE 3013

CMD ["grunt", "run"]

