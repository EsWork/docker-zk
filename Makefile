all: build

build:
	@docker build --tag=eswork/zk .
release: build
	@docker build --tag=eswork/zk:$(shell cat VERSION) .