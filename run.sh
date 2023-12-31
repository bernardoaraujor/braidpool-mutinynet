#!/bin/sh

# Set the Dockerfile according to host architecture
case "$(uname -s)" in
    Linux*)
        MACHINE=Linux
        case "$(uname -m)" in
            x86_64) DOCKERFILE_HOST_ARCH="Dockerfile_x86_64_linux_gnu";;
            aarch64) DOCKERFILE_HOST_ARCH="Dockerfile_aarch64_linux_gnu";;
            *) exit 1
        esac
        ;;
    Darwin*)
        MACHINE=Mac
        case "$(uname -m)" in
            arm64) DOCKERFILE_HOST_ARCH="Dockerfile_arm64_apple_darwin";;
            *) exit 1
        esac
        ;;
    *) exit 1
esac

# Set the image name and tag
IMAGE_NAME="custom-signet-bitcoin"
IMAGE_TAG="latest"

# Build the Docker image
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" . -f "${DOCKERFILE_HOST_ARCH}"

# Check if the build was successful
if [ $? -ne 0 ]; then
  echo "Error: Docker image build failed."
  exit 1
fi

# Run the Docker container
docker run -d -p 28332:28332 -p 28333:28333 -p 28334:28334 -p 38332:38332 -p 38333:38333 -p 38334:38334 --name custom-signet-node "${IMAGE_NAME}:${IMAGE_TAG}"

# Check if the container is running
if [ $? -eq 0 ]; then
  echo "Docker container '${IMAGE_NAME}' is now running."
else
  echo "Error: Docker container could not be started."
  exit 1
fi

# Display container information
docker ps

