IMAGE_NAME=roberta-sentiment
CONTAINER_NAME=roberta-sentiment-service
HUB_IMAGE := $(DOCKER_USERNAME)/$(IMAGE_NAME):latest

build:
	docker build -t $(IMAGE_NAME) .

run: build
	docker run --rm -it --name $(CONTAINER_NAME) $(IMAGE_NAME)

clean:
	docker image prune -f

cloud-install-uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh


cloud-install-deps: cloud-install-uv
	~/.local/bin/uv sync --locked

lint:
	uv run flake8 src

cloud-lint:
	~/.local/bin/uv run flake8 src

cloud-build-image:
	docker build -t $(HUB_IMAGE) .

cloud-push-image:
	docker push $(HUB_IMAGE)

cloud-build-push-image: cloud-build-image cloud-push-image