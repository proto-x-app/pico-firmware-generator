# Gebruik de officiële Ubuntu als een ouderafbeelding
FROM ubuntu:latest

# Set de maintainer label
LABEL maintainer="github@proto-x.app"

# Set omgevingsvariabelen in de Docker-afbeelding
ENV PICO_SDK_PATH="/workspace/sdk"
ENV PICO_EXAMPLES_PATH="/workspace/examples"

# Voer package-updates uit en installeer pakketten
RUN apt-get update \
    && apt-get install -y git \
    cmake \
    gcc-arm-none-eabi \
    libstdc++-arm-none-eabi-newlib \
    build-essential \
    python3

# Clone de pico-sdk repository en pico-examples als fallback
RUN git clone https://github.com/raspberrypi/pico-sdk.git $PICO_SDK_PATH

RUN cd $PICO_SDK_PATH && git submodule update --init

# Set de werkmap
WORKDIR /workspace

# Kopieer het firmware_generator.py-script naar de Docker-afbeelding
COPY src/firmware_generator.py /workspace/firmware_generator.py

# Voer het script uit
CMD ["python3", "firmware_generator.py"]
