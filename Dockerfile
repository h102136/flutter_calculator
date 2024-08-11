FROM ubuntu:oracular-20240617

WORKDIR /app

COPY . /app

RUN apt-get update
RUN apt-get install -y apt-transport-https wget gnupg
RUN apt-get update && apt-get install -y apt-transport-https wget gnupg lcov
CMD ["/bin/bash"]

