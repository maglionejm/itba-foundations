FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y install postgresql-client

COPY . /app_itba

WORKDIR /app_itba

CMD bash ./db_structure.sh