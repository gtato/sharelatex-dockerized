FROM gtato/sharelatex-base:latest

RUN apt-get update && apt-get install -y python git-core build-essential zlib1g-dev latexmk texlive-latex-base texlive-latex-extra

RUN git clone https://github.com/sharelatex/clsi-sharelatex.git /app
WORKDIR /app
RUN npm install v8-profiler 
RUN sed -i 's/localhost/0.0.0.0/g' config/settings.defaults.coffee ;\
    npm install ;\
    grunt install ;\
    mkdir /app/compiles /app/cache

EXPOSE 3013

CMD ["grunt", "run"]

