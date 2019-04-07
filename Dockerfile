FROM alpine:latest

ADD src /tempexporter
ADD res /res

RUN apk add  --no-cache --update \
    python \
    python-dev \
    py-pip \
    build-base
RUN pip install -r /res/requirements.txt


WORKDIR "/tempexporter"

ENTRYPOINT ["python", "endpoint.py"]