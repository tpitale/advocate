build:
	docker build -t advocate .

tag:
	docker tag advocate:latest ${DOCKER_REGISTRY}/advocate

push:
	docker push ${DOCKER_REGISTRY}/advocate

release: build tag push

run: build
	docker run -it -p 3000:80 --env-file .env --rm --name advocate advocate

console: build
	docker run -it -p 3000:80 --env-file .env --rm --name advocate advocate bin/rails c

shell:
	docker exec -it advocate /bin/bash
