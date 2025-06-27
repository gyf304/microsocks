FROM alpine:3 AS builder

RUN apk add --no-cache make gcc musl-dev

COPY . /app
WORKDIR /app

RUN make LDFLAGS="-static" CFLAGS="-static -Os -s"

FROM scratch
COPY --from=builder /app/microsocks /microsocks
ENTRYPOINT ["/microsocks"]
