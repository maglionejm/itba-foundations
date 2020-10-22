FROM python:3.6-slim

COPY requirements.txt /

RUN pip install -r /requirements.txt

COPY . /app_itba

WORKDIR /app_itba

CMD python3 reports.py