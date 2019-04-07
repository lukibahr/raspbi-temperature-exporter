#!/usr/bin/env python

"""
Prometheus running in kubernetes will automatically scrape this service.
"""

from prometheus_client import start_http_server, Gauge
import time
import os
import logging
from w1thermsensor import W1ThermSensor

# Create a metric to track time spent and requests made.
#TEMPERATURE = Gauge('temperature_in_celcius', 'Temperature in celcuis')

g = Gauge('temperature_in_celcius', 'Temperature in celcuis')
format = "%(asctime)s - %(levelname)s [%(name)s] %(threadName)s %(message)s"
logging.basicConfig(level=logging.INFO, format=format)
sensor = W1ThermSensor()

def process_temperature():
    """ a function to process the temperature """
    logging.info("temperature_in_celcius: {}".format(sensor.get_temperature()))
    g.set(sensor.get_temperature())
	
if __name__ == '__main__':
    # Start up the server to expose the metrics.
    if 'TEMPEXPORTER_PORT' in os.environ:
        logging.info("Running exporter on port: {}".format(os.getenv('TEMPEXPORTER_PORT')))
        start_http_server(int(os.getenv('TEMPEXPORTER_PORT')))
        # call process temperature function
        while True:
            process_temperature()
    else:
        logging.error("TEMPEXPORTER_PORT variable is not set.".format())
	
        