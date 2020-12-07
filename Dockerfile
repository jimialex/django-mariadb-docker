# base image
FROM python:3.6-slim

# environment for python logging
# send output to terminal without buffer
ENV PYTHONBUFFERED 1

# make workdir in container
# and copy current directory contents to workdir
RUN mkdir /app
WORKDIR /app
ADD . /app

# install needed packages
RUN apt-get update \
    && apt-get install -y default-libmysqlclient-dev build-essential \
    && pip install --trusted-host pypi.python.org -r requirements.txt \
    && apt-get remove -y default-libmysqlclient-dev build-essential

COPY ./requirements /requirements
RUN pip install --no-cache-dir -r /requirements/common.txt

# para ver el contenedor de la base de datos
# docker exec -it django-mariadb-docker_db_1 mysql -udocker -p
