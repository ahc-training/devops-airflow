ARG AIRFLOW_VERSION=2.7.2
FROM docker.io/apache/airflow:${AIRFLOW_VERSION}-python3.10

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc g++ libkrb5-dev build-essential libsasl2-dev openjdk-11-jdk ant procps \
    && apt-get autoremove -yqq --purge \
    && apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
RUN export JAVA_HOME

USER airflow

COPY requirements.txt /
RUN python -m pip install --upgrade pip
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir -r /requirements.txt

