FROM gtato/sharelatex-base:latest

RUN npm install express redis;\
    npm -g install node-inspector


EXPOSE 8006
        
ADD syncer.js /
CMD ["node", "syncer.js"]

