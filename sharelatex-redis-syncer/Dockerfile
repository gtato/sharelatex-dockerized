FROM gtato/sharelatex-base:latest

RUN apt install -y wget tcl python-pip redis-tools ;\
    pip install redis
        
ADD syncer.py /
CMD ["python", "-u", "syncer.py"]

