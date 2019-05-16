FROM arm32v6/python:2.7-alpine3.9

WORKDIR "/exporter"
ADD src .
ADD requirements.txt .
RUN pip install -r requirements.txt

ENTRYPOINT ["python", "endpoint.py"]