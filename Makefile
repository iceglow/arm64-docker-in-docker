NAME=arm64-docker-in-docker
REPO=gluffs/$(NAME)
REPO_URL=registry.gluffs.eu:5000

.PHONY: admin bash start build

all: build

build:
	docker build -t $(REPO) .

push:
	docker tag -f $(REPO) $(REPO_URL)/$(REPO)
	docker push $(REPO_URL)/$(REPO)

restart: stop rm start

start:
	docker run -d -p2375:2375 -v /etc/localtime:/etc/localtime:ro --privileged=true --device=/dev/ttyACM0 --restart=always --name $(NAME) $(REPO_URL)/$(REPO)

stop:
	docker stop $(NAME) || echo "Nothing to stop"

rm:
	docker rm -f $(NAME) || echo "Nothing to remove"

bash: CMD = bash
bash: build run

run:
	docker run -p2375:2375 -v /etc/localtime:/etc/localtime:ro --privileged=true --device=/dev/ttyACM0 -t -i --rm $(REPO) $(CMD)
