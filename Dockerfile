FROM python:3.9-alpine

RUN pip install --upgrade pip
RUN apk update
RUN apk --update --upgrade add gcc musl-dev jpeg-dev zlib-dev libffi-dev cairo-dev pango-dev gdk-pixbuf-dev
RUN pip install awscli

RUN pip install aws-sam-cli

WORKDIR /var/task

COPY ./template.yaml template.yml

VOLUME /var/run/docker.sock

EXPOSE 3001

ENTRYPOINT ["/bin/sh"]