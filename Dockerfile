# syntax = docker/dockerfile:1.0-experimental
FROM python:3.8.8-alpine
RUN mkdir /app
WORKDIR /app
COPY Pipfile /app

# RUN apk add --virtual=.run-deps chromium chromium-chromedriver openssl zlib libjpeg cargo rust && \
#     apk add --virtual=.build-deps build-base musl-dev libffi-dev libxslt-dev gcc jpeg-dev zlib-dev openssl-dbg openssl-dev && \
#     pip install pipenv && \
#     pipenv lock --requirements > requirements.txt && \
#     pip install -r requirements.txt && \
#     apk del .build-deps

RUN apk add --virtual .run-deps chromium chromium-chromedriver openssl zlib libjpeg && \
    apk add --no-cache --virtual .build-deps gcc musl-dev libc-dev libxslt-dev libffi-dev jpeg-dev openssl-dev cargo rust && \
    pip3 install cryptography && \
    pip3 install pipenv && \
    pip install lxml && \
    pipenv lock --requirements > requirements.txt && \
    pip3 install -r requirements.txt && \
    apk del .build-deps

COPY . /app
CMD ["python3", "app.py", "amazon", "--headless"]