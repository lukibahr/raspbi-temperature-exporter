FROM alpine:alpine:3.7

ADD src /exporter
ADD lib /lib

RUN apk add  --no-cache --update \
    python \
    python-dev \
    py-pip \
    build-base
RUN pip install -r /lib/requirements.txt


WORKDIR "/exporter"

ENTRYPOINT ["python", "endpoint.py"]