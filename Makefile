IMAGE_NAME=roberta-sentiment
CONTAINER_NAME=roberta-sentiment-service
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

.PHONY: push
push:
	docker push $(CONTAINER_NAME):latest