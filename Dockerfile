FROM golang:1.9 as builder
RUN mkdir -p /go/src/demo
WORKDIR /go/src/demo
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/demo/app .
CMD ["./app"]