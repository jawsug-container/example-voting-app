FROM pottava/python:2.7

RUN apk --no-cache add --virtual build-dependencies py-pip && \
    mkdir /app && \
    cd /app && \
    echo -e "Flask\nRedis" > /app/requirements.txt && \
    pip install -r requirements.txt && \
    apk del build-dependencies
