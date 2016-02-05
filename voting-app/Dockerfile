FROM pottava/python:2.7

ADD . /app
WORKDIR /app

RUN apk --no-cache add py-pip && \
    pip install -r requirements.txt && \
    apk del py-pip

EXPOSE 80 

CMD ["python", "app.py"]
