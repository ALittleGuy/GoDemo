PROJECT = "GoDemo"
VETPACAKGE = `go list ./...`
default:
	@echo ${PROJECT}
	@go vet $(VETPACAKGE)
	@go build -o app internal/main.go
	@./app

build:
	@echo ${PROJECT} build
	@go vet $(VETPACAKGE)
	@go build -o app internal/main.go

test:
	@echo ${PROJECT} test

docker:
	@echo ${PROJECT} docker
	docker build --rm -t homerpan/godemo .
	docker image prune --filter label=stage=builder
	docker run --rm -it --name GoDemo -p 8080:8080 homerpan/godemo:latest
