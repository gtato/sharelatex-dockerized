FROM ubuntu:latest

RUN apt -y install liblapack-dev libgfortran-4.8-dev libatlas-base-dev libatlas-dev python-dev pkg-config libfreetype6-dev gfortran vim vim-youcompleteme python-virtualenv

ADD requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt --upgrade