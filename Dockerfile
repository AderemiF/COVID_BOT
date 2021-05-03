
FROM python:3.8.0

# remember to expose the port your app'll be exposed on.
EXPOSE 8080

RUN apt-get install libsm6 libxext6  -y
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils 
RUN pip install -U pip

COPY requirements.txt app/requirements.txt
RUN pip install -r app/requirements.txt
# copy into a directory of its own (so it isn't in the toplevel dir)
COPY . /app
WORKDIR /app

# run it!
ENTRYPOINT ["run", "app.py", "--server.port=8080", "--server.address=0.0.0.0", "--server.maxUploadSize=20"]