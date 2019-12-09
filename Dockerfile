FROM python:3.6
ENV PYTHONUNBUFFERED 1

RUN apt-get -y update -qq && \
    apt-get -y install locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get install -y python-mysqldb \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/*

RUN mkdir /app/
RUN mkdir /app/.pip
RUN mkdir /app/logs/flask -p
RUN mkdir /app/logs/uwsgi -p
WORKDIR /app

COPY . /app/
COPY ./docker_entrypoint.sh /
RUN pip install --cache-dir=.pip -r requirements.txt
RUN pip install --cache-dir=.pip uwsgi

ENTRYPOINT ["/docker_entrypoint.sh"]

CMD ["runserver"]
