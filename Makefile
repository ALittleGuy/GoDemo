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

