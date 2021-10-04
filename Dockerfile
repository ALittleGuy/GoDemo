FROM golang:1.9 as builder
LABEL stage=builder
RUN mkdir -p /go/src/demo/internal/handler
WORKDIR /go/src/demo
COPY internal/main.go ./internal
COPY internal/handler/* ./internal/handler
RUN CGO_ENABLED=0 GOOS=linux go build -o app /go/src/demo/internal/main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
EXPOSE 8080
WORKDIR /root/
COPY --from=builder /go/src/demo/app .
CMD ["./app"]