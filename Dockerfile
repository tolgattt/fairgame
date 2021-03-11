# syntax = docker/dockerfile:1.0-experimental
FROM python:3.8.8-alpine
WORKDIR /app
COPY Pipfile /app

RUN apk add --virtual=.run-deps chromium chromium-chromedriver openssl zlib libjpeg cargo rust && \
    apk add --virtual=.build-deps build-base musl-dev libffi-dev libxml2-dev libxslt-dev gcc jpeg-dev zlib-dev openssl-dbg openssl-dev cargo rust && \
    pip install --upgrade pip && \
    pip install cryptography && \
    pip install pipenv && \
    pipenv lock --requirements > requirements.txt && \
    pip install -r requirements.txt

COPY . /app
CMD ["python3", "app.py", "amazon", "--headless"]