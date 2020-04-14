FROM hypriot/rpi-alpine:3.6

RUN apk --no-cache add python3 gcc python3-dev libc-dev

WORKDIR /exporter
COPY src .
COPY requirements.txt .
RUN pip3 install -r requirements.txt

ENTRYPOINT ["python", "endpoint.py"]
