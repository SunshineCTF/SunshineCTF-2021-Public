# FROM golang:1.15.4

# WORKDIR /go/src/flag-vault-1
# COPY . .

# RUN go get -d -v ./...
# RUN go install -v ./...
# RUN go build -o flag-vault-1 ./...

# CMD ["flag-vault-1"]

# WEBUI
# FROM node:12.11 as webui

# ENV WEBUI_DIR /src/webui
# RUN mkdir -p $WEBUI_DIR

# COPY ./webui/ $WEBUI_DIR/

# WORKDIR $WEBUI_DIR

# RUN npm install
# RUN npm run build

# BUILD
FROM golang:1.17-alpine as gobuild

RUN apk --update upgrade \
    && apk --no-cache --no-progress add git mercurial bash gcc musl-dev curl tar ca-certificates tzdata \
    && update-ca-certificates \
    && rm -rf /var/cache/apk/*

WORKDIR /go/src/github.com/SunshineCTF-2021-Private/Web/flag-vault-1

# Download go modules
COPY go.mod .
COPY go.sum .
RUN GO111MODULE=on GOPROXY=https://proxy.golang.org go mod download

COPY . /go/src/github.com/SunshineCTF-2021-Private/Web/flag-vault-1

RUN GO111MODULE=on GOPROXY=https://proxy.golang.org go build -o /go/src/github.com/SunshineCTF-2021-Private/Web/flag-vault-1/dist/flag-vault-1 . 

## IMAGE
FROM alpine:3.14

RUN apk --no-cache --no-progress add bash curl ca-certificates tzdata \
    && update-ca-certificates \
    && rm -rf /var/cache/apk/*

COPY --from=gobuild /go/src/github.com/SunshineCTF-2021-Private/Web/flag-vault-1/dist/ /

EXPOSE 3000
VOLUME ["/tmp"]

ENTRYPOINT ["/flag-vault-1"]