FROM hypriot/rpi-alpine

RUN apk add python-pip && apk add python py-pip

WORKDIR "/exporter"
ADD src .
ADD requirements.txt .
RUN pip install -r requirements.txt

ENTRYPOINT ["python", "endpoint.py"]
