# Makefile for Proto-X-App Pico Firmware Generator

# Variables
IMAGE_NAME=pico-firmware-generator
CONTAINER_NAME=pico-container
OUTPUT_DIR=${HOME}/Code/proto-x-app/pico-firmware-generator/output

# Build the Docker image
build:
	@docker build -t $(IMAGE_NAME) .

# Run the Docker container
run:
	mkdir -p $(OUTPUT_DIR)
	@docker run -it --rm --name $(CONTAINER_NAME) -v $(OUTPUT_DIR):/output $(IMAGE_NAME)

# Build and Run
all: build run

# Remove Docker images and containers
clean:
	@docker rmi -f $(IMAGE_NAME)
	@docker rm -f $(CONTAINER_NAME)

.PHONY: build run all clean
