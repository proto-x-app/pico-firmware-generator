# Use a slimmer base image
FROM ubuntu:rolling

# Set the maintainer label
LABEL maintainer="github@proto-x.app"

# Set environment variables in the Docker image
ENV PICO_SDK_PATH="/workspace/sdk"
ENV PICO_EXAMPLES_PATH="/workspace/examples"

# Update, install necessary packages, and clean up in a single step to reduce layer size
RUN apt-get update && \
    apt-get install -y git cmake gcc-arm-none-eabi libstdc++-arm-none-eabi-newlib build-essential python3 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Copy the firmware_generator.py script to the Docker image
COPY src/firmware_generator.py /workspace/firmware_generator.py

# Run the script
CMD ["python3", "firmware_generator.py"]
