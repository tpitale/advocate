build:
	docker build -t advocate .

tag: build
	docker tag $(shell docker images advocate:latest -q) ${DOCKER_REGISTRY}/advocate

push: tag
	docker push ${DOCKER_REGISTRY}/advocate

run: build
	docker run -it -p 3000:80 --env-file .env --rm --name advocate advocate

console: build
	docker run -it -p 3000:80 --env-file .env --rm --name advocate advocate bin/rails c

shell:
	docker exec -it advocate /bin/bash
