# syntax = docker/dockerfile:1.0-experimental
FROM python:3.8.8
RUN mkdir /app
WORKDIR /app
COPY Pipfile /app

# RUN apk add --virtual=.run-deps chromium chromium-chromedriver openssl zlib libjpeg cargo rust && \
#     apk add --virtual=.build-deps build-base musl-dev libffi-dev libxslt-dev gcc jpeg-dev zlib-dev openssl-dbg openssl-dev && \
#     pip install pipenv && \
#     pipenv lock --requirements > requirements.txt && \
#     pip install -r requirements.txt && \
#     apk del .build-deps

RUN apt-get update \
    && apt-get install -y

RUN apt install python3-pip -y && \
    pip3 install pipenv && \
    export PATH=\"/home/$USER/.local/bin:$PATH\" && \
    pipenv lock --requirements > requirements.txt && \
    pip3 install --no-cache-dir -r requirements.txt

COPY . /app
CMD ["python3", "app.py", "amazon", "--headless"]