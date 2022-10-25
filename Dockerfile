FROM python:3.8-alpine

RUN pip install -U pip awscli && \
    apk add --no-cache --update rsync

COPY . /src
WORKDIR /src
RUN mkdir /.aws && chown 50000:50000 /.aws

USER 50000

CMD ["/bin/sh","/src/run.sh"]
