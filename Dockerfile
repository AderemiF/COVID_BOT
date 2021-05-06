
FROM python:3.8.0-slim-buster

# remember to expose the port your app'll be exposed on.
EXPOSE 5000

COPY requirements.txt app/requirements.txt
RUN pip install -r app/requirements.txt

RUN apt-get update && \
    apt-get -y install --no-install-recommends build-essential && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apt autoremove -y && \
    apt-get -y remove build-essential && \
    apt-get -y install curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# copy into a directory of its own (so it isn't in the toplevel dir)
COPY . /app
WORKDIR /app

# run it!
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:5000", "--forwarded-allow-ips", "*", "app:app"]