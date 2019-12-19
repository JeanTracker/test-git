# Container image that runs your code
FROM ubuntu:latest

ENV HELLO=WORLD!!

# ENV DEBIAN_FRONTEND=noninteractive \
#     LC_ALL=en_US.UTF-8 \
#     LANG=$LC_ALL

# RUN apt-get update && apt install -y software-properties-common

# RUN add-apt-repository ppa:nugulinux/sdk -y && apt-get update && apt-get install -y \
#     cmake clang clang-tidy \
#     libglib2.0 libglib2.0-dev libssl1.1 libssl-dev \
#     zlib1g zlib1g-dev libasound2 libasound2-dev libportaudio2 portaudio19-dev \
#     libopus0 libopus-dev libgstreamer1.0-0 libgstreamer1.0-dev \
#     libgstreamer-plugins-base1.0-0 libgstreamer-plugins-base1.0-dev \
#     libnugu-epd-dev libnugu-kwd-dev \
#     python-pip

# RUN pip install pyyaml

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
