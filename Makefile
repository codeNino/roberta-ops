IMAGE_NAME=roberta-sentiment
CONTAINER_NAME=roberta-sentiment-service
HUB_IMAGE := $(DOCKER_USERNAME)/$(IMAGE_NAME):latest
# Build the Docker image
.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

# Run the Docker container
.PHONY: run
run: build
	docker run --rm -it --name $(CONTAINER_NAME) $(IMAGE_NAME)

# Clean up dangling images
.PHONY: clean
clean:
	docker image prune -f


cloud-build-image:
	docker build -t $(HUB_IMAGE) .

cloud-push-image:
	docker push $(HUB_IMAGE)

cloud-build-push-image: cloud-build-image cloud-push-image