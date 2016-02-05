FROM pottava/python:2.7

WORKDIR /app

ADD requirements.txt /app/requirements.txt
RUN apk --no-cache add py-pip && \
    pip install -r requirements.txt && \
    apk del py-pip

ADD . /app

EXPOSE 80 

CMD ["python", "app.py"]
