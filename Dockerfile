FROM golang:1.16.5-alpine AS build
ENV GO111MODULE=auto
RUN apk add --no-cache git
RUN go get github.com/caarlos0/env && go get github.com/prometheus/client_golang/prometheus && go get github.com/prometheus/client_golang/prometheus/promhttp && go get github.com/lib/pq
WORKDIR /go/src/gocalc
COPY main.go main.go
RUN go build -o app .

FROM alpine:3.10.3
COPY --from=build /go/src/gocalc/app /usr/local/bin/app
CMD ["/usr/local/bin/app"]
