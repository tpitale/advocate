build:
	docker build --build-arg BUILD_ENV=${BUILD_ENV} -t advocate_${BUILD_ENV} .

tag:
	docker tag advocate_${BUILD_ENV}:latest ${DOCKER_REGISTRY}/advocate_${BUILD_ENV}

push:
	docker push ${DOCKER_REGISTRY}/advocate_${BUILD_ENV}

release: build tag push

run: build
	docker run -it -p 3000:80 --env-file .env --rm --name advocate advocate_${BUILD_ENV}

console: build
	docker run -it -p 3000:80 --env-file .env --rm --name advocate advocate_${BUILD_ENV} bin/rails c

shell:
	docker exec -it advocate /bin/bash
