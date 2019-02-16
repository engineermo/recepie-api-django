FROM python:3.7.2-alpine3.9
MAINTAINER dia

ENV PYTHONUNBUFFERED 1
#ENV http_proxy http://proxyvipfmcc.nb.ford.com:83/
#ENV https_proxy http://proxyvipfmcc.nb.ford.com:83/


COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
