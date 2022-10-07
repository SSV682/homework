FROM golang:1.19.2-alpine as base
WORKDIR /build
ENV CGO_ENABLED=0
COPY go.* ./
RUN go mod download
COPY . .

FROM base as build
COPY --from=base /go/pkg /go/pkg
COPY . /app
RUN GOOS=linux GOARCH=arm \
    go build -o /bin/app ./cmd/app
#--mount type=cache,target=/root/.cache/go-build \

FROM scratch AS bin-unix
COPY --from=build /app/config /config
COPY --from=build /bin/app /app
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs
CMD ["/app"]
